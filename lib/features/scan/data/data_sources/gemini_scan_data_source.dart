import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/firebase/gemini_generator.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';

final class GeminiScanDataSource {
  GeminiScanDataSource(this._gemini);

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

  final GeminiGenerator _gemini;

  TaskEither<AppFailure, String> recognizeIngredients(Uint8List photo) =>
      _generate(photo, _ingredientsPrompt, _ingredientsSchema);

  TaskEither<AppFailure, String> readBestBefore(Uint8List photo) => _generate(photo, _datePrompt, _dateSchema);

  TaskEither<AppFailure, String> _generate(Uint8List photo, String prompt, Schema schema) => _gemini
      .generate(<Part>[TextPart(prompt), InlineDataPart('image/jpeg', photo)], schema, logName: 'mijoo.scan')
      .mapLeft(
        (GeminiError error) => switch (error) {
          GeminiError.busy => const ScanBusy(),
          GeminiError.quotaReached => const ScanQuotaReached(),
          GeminiError.unavailable => const ScanUnavailable(),
          GeminiError.network => const ScanNetworkFailure(),
        },
      );

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
