import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/scan/data/mappers/scan_proposal_mapper.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

Option<ScanProposal> openFoodFactsToScanProposal(Product product) =>
    Option<String>.fromNullable(
      <String?>[
        product.productNameInLanguages?[OpenFoodFactsLanguage.FRENCH],
        product.productName,
        product.genericName,
      ].nonNulls.map((String name) => name.trim()).where((String name) => name.isNotEmpty).firstOrNull,
    ).map((String name) {
      final (double quantity, FridgeUnit unit) = openFoodFactsToQuantity(product.quantity ?? '');
      return ScanProposal(
        name: name.length > maxProposalNameLength ? name.substring(0, maxProposalNameLength).trim() : name,
        quantity: quantity,
        unit: unit,
        category: openFoodFactsToCategory(product.categoriesTags ?? <String>[]),
        confidence: ScanConfidence.sure,
      );
    });

(double, FridgeUnit) openFoodFactsToQuantity(String label) =>
    Option<RegExpMatch>.fromNullable(
          RegExp(r'^\s*(\d+(?:[.,]\d+)?)\s*(kg|g|ml|cl|l)\b', caseSensitive: false).firstMatch(label),
        )
        .flatMap(
          (RegExpMatch match) => parseFridgeQuantity(match.group(1) ?? '').map(
            (double amount) => switch (match.group(2)?.toLowerCase()) {
              'kg' => (amount, FridgeUnit.kilogram),
              'g' => (amount, FridgeUnit.gram),
              'ml' => (amount, FridgeUnit.milliliter),
              'cl' => (amount * 10, FridgeUnit.milliliter),
              _ => (amount, FridgeUnit.liter),
            },
          ),
        )
        .getOrElse(() => (1, FridgeUnit.piece));

FridgeCategory openFoodFactsToCategory(List<String> tags) => switch (tags.toSet()) {
  final Set<String> set when set.contains('en:frozen-foods') => FridgeCategory.frozen,
  final Set<String> set when set.contains('en:dairies') => FridgeCategory.dairy,
  final Set<String> set when set.intersection(<String>{'en:meats', 'en:fishes', 'en:seafood'}).isNotEmpty =>
    FridgeCategory.meatFish,
  final Set<String> set
      when set.intersection(<String>{'en:fruits', 'en:vegetables', 'en:fresh-vegetables'}).isNotEmpty =>
    FridgeCategory.fruitsVegetables,
  final Set<String> set when set.contains('en:beverages') => FridgeCategory.drinks,
  _ => FridgeCategory.grocery,
};
