import 'dart:developer';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';

/// Why a Gemini request failed, before each feature turns it into its own failure.
enum GeminiError {
  /// The model is overloaded (server error or high demand): retrying later may work.
  busy,

  /// The free daily quota of the model is spent.
  quotaReached,

  /// Firebase AI Logic is not configured, not enabled or not available here.
  unavailable,

  /// The request did not reach the service.
  network,
}

/// Sends structured requests to Gemini through Firebase AI Logic.
///
/// Every request first tries [model] twice, then [fallbackModel]. A spent quota skips the
/// remaining attempts on the same model. The answer is the raw JSON text of the response.
final class GeminiGenerator {
  GeminiGenerator(this._connection, {Duration retryDelay = const Duration(seconds: 2)}) : _retryDelay = retryDelay;

  /// Main model, the lightest one: it has the largest free quota.
  static const String model = 'gemini-3.5-flash-lite';

  /// Model used once the main one is overloaded or out of quota.
  static const String fallbackModel = 'gemini-3.8-flash';

  /// Models tried in turn for one request.
  static const List<String> attempts = <String>[model, model, fallbackModel];

  final FirebaseConnection _connection;
  final Duration _retryDelay;

  /// Generates a JSON answer following [schema] from [parts] (text, images).
  ///
  /// [logName] names the feature in the logs; [temperature] trades accuracy for variety.
  TaskEither<GeminiError, String> generate(
    List<Part> parts,
    Schema schema, {
    required String logName,
    double temperature = 0,
  }) => _generate(parts, schema, logName, temperature, 0);

  TaskEither<GeminiError, String> _generate(
    List<Part> parts,
    Schema schema,
    String logName,
    double temperature,
    int attempt,
  ) => _request(attempts[attempt], parts, schema, logName, temperature).orElse(
    (GeminiError error) => switch ((error, _nextAttempt(attempt, error))) {
      (GeminiError.busy || GeminiError.quotaReached, Some(value: final int next)) => TaskEither<GeminiError, String>(
        () => Future<void>.delayed(
          attempts[next] == attempts[attempt] ? _retryDelay : Duration.zero,
        ).then((_) => _generate(parts, schema, logName, temperature, next).run()),
      ),
      _ => TaskEither<GeminiError, String>.left(error),
    },
  );

  Option<int> _nextAttempt(int attempt, GeminiError error) => Option<int>.fromNullable(
    <int>[
      for (int next = attempt + 1; next < attempts.length; next++)
        if (error != GeminiError.quotaReached || attempts[next] != attempts[attempt]) next,
    ].firstOrNull,
  );

  TaskEither<GeminiError, String> _request(
    String model,
    List<Part> parts,
    Schema schema,
    String logName,
    double temperature,
  ) => _connection.isConfigured
      ? TaskEither<GeminiError, String>.tryCatch(
          () async {
            final FirebaseAI ai = await _connection.ai;
            final GenerateContentResponse response = await ai
                .generativeModel(
                  model: model,
                  generationConfig: GenerationConfig(
                    responseMimeType: 'application/json',
                    responseSchema: schema,
                    temperature: temperature,
                  ),
                )
                .generateContent(<Content>[Content.multi(parts)]);
            return response.text ?? '';
          },
          (Object error, StackTrace stack) {
            log(
              switch (error) {
                FirebaseAIException(:final String message) => 'generate $model $message',
                _ => 'generate ${error.runtimeType}',
              },
              name: logName,
              stackTrace: stack,
            );
            return switch (error) {
              FirebaseAIException(:final String message) when message.toLowerCase().contains('quota') =>
                GeminiError.quotaReached,
              FirebaseAIException(:final String message)
                  when message.startsWith('Server Error [5') ||
                      message.contains('high demand') ||
                      message.contains('overloaded') =>
                GeminiError.busy,
              InvalidApiKey() || UnsupportedUserLocation() => GeminiError.unavailable,
              FirebaseAIException(:final String message)
                  when message.contains('firebasevertexai.googleapis.com') ||
                      message.contains('generativelanguage.googleapis.com') =>
                GeminiError.unavailable,
              _ => GeminiError.network,
            };
          },
        )
      : TaskEither<GeminiError, String>.left(GeminiError.unavailable);
}
