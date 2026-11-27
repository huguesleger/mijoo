import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';

final class GeminiScanDataSource {
  GeminiScanDataSource(this._connection, {Duration retryDelay = const Duration(seconds: 2)}) : _retryDelay = retryDelay;

  static const String model = 'gemini-3.5-flash-lite';
  static const String fallbackModel = 'gemini-3.8-flash';
  static const List<String> attempts = <String>[model, model, fallbackModel];

  static const String _ingredientsPrompt = '''
Tu aides une famille à faire l’inventaire de son frigo à partir d’une photo.
Liste uniquement les aliments réellement visibles, en français, au singulier ou au pluriel naturel (« Tomates », « Lait demi-écrémé »).
Pour chacun, estime la quantité visible et choisis l’unité la plus naturelle parmi les valeurs proposées.
Indique « uncertain » quand l’aliment est partiellement caché, flou ou difficile à identifier.
N’invente jamais d’aliment absent de la photo et ignore les objets qui ne se mangent pas.
Ne mentionne aucune personne ni aucune information personnelle.''';

  static const String _datePrompt = '''
Lis la date limite de consommation imprimée sur l’emballage de cette photo (DLC, « à consommer jusqu’au », « à consommer de préférence avant »).
Réponds avec la date au format AAAA-MM-JJ. Si l’année manque, choisis la prochaine occurrence de ce jour.
Si aucune date n’est lisible avec certitude, réponds null.''';

  final FirebaseConnection _connection;
  final Duration _retryDelay;

  TaskEither<AppFailure, String> recognizeIngredients(Uint8List photo) =>
      _generate(photo, _ingredientsPrompt, _ingredientsSchema);

  TaskEither<AppFailure, String> readBestBefore(Uint8List photo) => _generate(photo, _datePrompt, _dateSchema);

  TaskEither<AppFailure, String> _generate(Uint8List photo, String prompt, Schema schema, {int attempt = 0}) =>
      _request(attempts[attempt], photo, prompt, schema).orElse(
        (AppFailure failure) => switch ((failure, _nextAttempt(attempt, failure))) {
          (ScanBusy() || ScanQuotaReached(), Some(value: final int next)) => TaskEither<AppFailure, String>(
            () => Future<void>.delayed(
              attempts[next] == attempts[attempt] ? _retryDelay : Duration.zero,
            ).then((_) => _generate(photo, prompt, schema, attempt: next).run()),
          ),
          _ => TaskEither<AppFailure, String>.left(failure),
        },
      );

  Option<int> _nextAttempt(int attempt, AppFailure failure) => Option<int>.fromNullable(
    <int>[
      for (int next = attempt + 1; next < attempts.length; next++)
        if (failure is! ScanQuotaReached || attempts[next] != attempts[attempt]) next,
    ].firstOrNull,
  );

  TaskEither<AppFailure, String> _request(String model, Uint8List photo, String prompt, Schema schema) =>
      _connection.isConfigured
      ? TaskEither<AppFailure, String>.tryCatch(
          () async {
            final FirebaseAI ai = await _connection.ai;
            final GenerateContentResponse response = await ai
                .generativeModel(
                  model: model,
                  generationConfig: GenerationConfig(
                    responseMimeType: 'application/json',
                    responseSchema: schema,
                    temperature: 0,
                  ),
                )
                .generateContent(<Content>[
                  Content.multi(<Part>[TextPart(prompt), InlineDataPart('image/jpeg', photo)]),
                ]);
            return response.text ?? '';
          },
          (Object error, StackTrace stack) {
            log(
              switch (error) {
                FirebaseAIException(:final String message) => 'generate $model $message',
                _ => 'generate ${error.runtimeType}',
              },
              name: 'mijoo.scan',
              stackTrace: stack,
            );
            return switch (error) {
              FirebaseAIException(:final String message) when message.toLowerCase().contains('quota') =>
                const ScanQuotaReached(),
              FirebaseAIException(:final String message)
                  when message.startsWith('Server Error [5') ||
                      message.contains('high demand') ||
                      message.contains('overloaded') =>
                const ScanBusy(),
              InvalidApiKey() || UnsupportedUserLocation() => const ScanUnavailable(),
              FirebaseAIException(:final String message)
                  when message.contains('firebasevertexai.googleapis.com') ||
                      message.contains('generativelanguage.googleapis.com') =>
                const ScanUnavailable(),
              _ => const ScanNetworkFailure(),
            };
          },
        )
      : TaskEither<AppFailure, String>.left(const ScanUnavailable());

  static final Schema _ingredientsSchema = Schema.object(
    properties: <String, Schema>{
      'ingredients': Schema.array(
        items: Schema.object(
          properties: <String, Schema>{
            'name': Schema.string(),
            'quantity': Schema.number(),
            'unit': Schema.enumString(enumValues: <String>[for (final FridgeUnit unit in FridgeUnit.values) unit.name]),
            'category': Schema.enumString(
              enumValues: <String>[for (final FridgeCategory category in FridgeCategory.values) category.name],
            ),
            'confidence': Schema.enumString(
              enumValues: <String>[for (final ScanConfidence confidence in ScanConfidence.values) confidence.name],
            ),
          },
        ),
      ),
    },
  );

  static final Schema _dateSchema = Schema.object(
    properties: <String, Schema>{'bestBefore': Schema.string(nullable: true, description: 'AAAA-MM-JJ')},
  );
}
