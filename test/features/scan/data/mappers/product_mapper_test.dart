import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/data/mappers/product_mapper.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() {
  test('turns a product into a proposal with its size and shelf', () {
    final ScanProposal proposal = openFoodFactsToScanProposal(
      Product(productName: 'Lait demi-écrémé', quantity: '1 L', categoriesTags: <String>['en:dairies', 'en:milks']),
    ).getOrElse(() => throw StateError('no proposal'));

    expect(proposal.name, 'Lait demi-écrémé');
    expect(proposal.quantity, 1);
    expect(proposal.unit, FridgeUnit.liter);
    expect(proposal.category, FridgeCategory.dairy);
  });

  test('ignores a product without a name', () {
    expect(openFoodFactsToScanProposal(Product(productName: '  ')), isA<None>());
  });

  test('reads the usual sizes', () {
    expect(openFoodFactsToQuantity('500 g'), (500.0, FridgeUnit.gram));
    expect(openFoodFactsToQuantity('1,5 kg'), (1.5, FridgeUnit.kilogram));
    expect(openFoodFactsToQuantity('75 cl'), (750.0, FridgeUnit.milliliter));
    expect(openFoodFactsToQuantity('6 x 125 g'), (1.0, FridgeUnit.piece));
    expect(openFoodFactsToQuantity(''), (1.0, FridgeUnit.piece));
  });

  test('picks the shelf from the categories', () {
    expect(openFoodFactsToCategory(<String>['en:frozen-foods', 'en:vegetables']), FridgeCategory.frozen);
    expect(openFoodFactsToCategory(<String>['en:beverages', 'en:sodas']), FridgeCategory.drinks);
    expect(openFoodFactsToCategory(<String>['en:fishes']), FridgeCategory.meatFish);
    expect(openFoodFactsToCategory(<String>['en:pastas']), FridgeCategory.grocery);
  });
}
