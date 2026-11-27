import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/data/mappers/scan_proposal_mapper.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';

void main() {
  group('geminiToScanProposals', () {
    test('reads the ingredients of the response', () {
      final List<ScanProposal> proposals = geminiToScanProposals(
        '{"ingredients":[{"name":" Tomates ","quantity":4,"unit":"piece","category":"fruitsVegetables",'
        '"confidence":"sure"},{"name":"Lait","quantity":1.5,"unit":"liter","category":"dairy",'
        '"confidence":"uncertain"}]}',
      ).getOrElse(() => <ScanProposal>[]);

      expect(proposals.map((ScanProposal proposal) => proposal.name), <String>['Tomates', 'Lait']);
      expect(proposals.first.unit, FridgeUnit.piece);
      expect(proposals.last.quantity, 1.5);
      expect(proposals.last.category, FridgeCategory.dairy);
      expect(proposals.last.confidence, ScanConfidence.uncertain);
    });

    test('skips nameless ingredients and repairs unknown values', () {
      final List<ScanProposal> proposals = geminiToScanProposals(
        '{"ingredients":[{"name":""},{"name":"Beurre","quantity":-2,"unit":"tonne","category":"jardin"}]}',
      ).getOrElse(() => <ScanProposal>[]);

      expect(proposals, hasLength(1));
      expect(proposals.single.quantity, 1);
      expect(proposals.single.unit, FridgeUnit.piece);
      expect(proposals.single.category, FridgeCategory.other);
      expect(proposals.single.confidence, ScanConfidence.uncertain);
    });

    test('rejects a response that is not the expected JSON', () {
      expect(geminiToScanProposals('pas du json'), isA<None>());
      expect(geminiToScanProposals('{"items":[]}'), isA<None>());
    });
  });

  group('geminiToBestBefore', () {
    test('reads the printed date', () {
      expect(geminiToBestBefore('{"bestBefore":"2026-12-04"}'), some(DateTime(2026, 12, 4)));
    });

    test('returns nothing when no date was read', () {
      expect(geminiToBestBefore('{"bestBefore":null}'), isA<None>());
      expect(geminiToBestBefore('{"bestBefore":"bientôt"}'), isA<None>());
      expect(geminiToBestBefore('{"bestBefore":"1899-01-01"}'), isA<None>());
    });
  });
}
