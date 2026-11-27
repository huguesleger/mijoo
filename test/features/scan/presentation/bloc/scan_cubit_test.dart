import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';
import 'package:mijoo/features/scan/domain/scan_repository.dart';
import 'package:mijoo/features/scan/presentation/bloc/scan_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockScanRepository extends Mock implements ScanRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  const HouseholdId household = HouseholdId('h1');
  final Uint8List photo = Uint8List.fromList(<int>[1, 2, 3]);
  const ScanProposal tomatoes = ScanProposal(
    name: 'Tomates',
    quantity: 3,
    unit: FridgeUnit.piece,
    category: FridgeCategory.fruitsVegetables,
    confidence: ScanConfidence.sure,
  );
  const ScanProposal milk = ScanProposal(
    name: 'Lait',
    quantity: 1,
    unit: FridgeUnit.liter,
    category: FridgeCategory.dairy,
    confidence: ScanConfidence.uncertain,
  );
  final FridgeItem storedTomatoes = FridgeItem(
    id: const FridgeItemId('tomates'),
    name: 'tomates',
    quantity: 2,
    unit: FridgeUnit.piece,
    category: FridgeCategory.fruitsVegetables,
    bestBefore: none(),
  );
  late MockScanRepository scan;
  late MockFridgeRepository fridge;

  setUpAll(() {
    registerFallbackValue(milk.input);
    registerFallbackValue(const FridgeItemId('x'));
  });

  setUp(() {
    scan = MockScanRepository();
    fridge = MockFridgeRepository();
    when(() => fridge.watchItems(household)).thenAnswer(
      (_) => Stream<Either<AppFailure, List<FridgeItem>>>.value(right(<FridgeItem>[storedTomatoes])),
    );
  });

  ScanCubit build() => ScanCubit(
    household: household,
    source: PhotoSource.camera,
    scan: scan,
    fridge: fridge,
    minimalLoading: Duration.zero,
  );

  blocTest<ScanCubit, ScanState>(
    'proposes the recognized ingredients and spots the ones already in the fridge',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => scan.recognizeIngredients(photo)).thenReturn(TaskEither.right(<ScanProposal>[tomatoes, milk]));
      return build();
    },
    act: (ScanCubit cubit) => cubit.start(),
    expect: () => <Matcher>[
      isA<ScanTakingPhoto>(),
      isA<ScanAnalyzing>(),
      isA<ScanReview>()
          .having((ScanReview state) => state.lines.map((ScanLine line) => line.input.name), 'names', <String>[
            'Tomates',
            'Lait',
          ])
          .having((ScanReview state) => state.lines.first.existing, 'existing', some(storedTomatoes))
          .having((ScanReview state) => state.lines.last.existing, 'new', isA<None>()),
    ],
  );

  blocTest<ScanCubit, ScanState>(
    'leaves when the photo is cancelled',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(none()));
      return build();
    },
    act: (ScanCubit cubit) => cubit.start(),
    expect: () => <Matcher>[isA<ScanTakingPhoto>(), isA<ScanCancelled>()],
  );

  blocTest<ScanCubit, ScanState>(
    'says when nothing was recognized',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => scan.recognizeIngredients(photo)).thenReturn(TaskEither.right(<ScanProposal>[]));
      return build();
    },
    act: (ScanCubit cubit) => cubit.start(),
    expect: () => <Matcher>[isA<ScanTakingPhoto>(), isA<ScanAnalyzing>(), isA<ScanNothingFound>()],
  );

  blocTest<ScanCubit, ScanState>(
    'shows the failure of the analysis',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => scan.recognizeIngredients(photo)).thenReturn(TaskEither.left(const ScanQuotaReached()));
      return build();
    },
    act: (ScanCubit cubit) => cubit.start(),
    expect: () => <Matcher>[
      isA<ScanTakingPhoto>(),
      isA<ScanAnalyzing>(),
      isA<ScanFailed>().having((ScanFailed state) => state.failure, 'failure', const ScanQuotaReached()),
    ],
  );

  blocTest<ScanCubit, ScanState>(
    'adds only the checked ingredients and merges the ones already in the fridge',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(
        () => scan.recognizeIngredients(photo),
      ).thenReturn(TaskEither.right(<ScanProposal>[tomatoes, milk, tomatoes]));
      when(() => fridge.addItem(household, any())).thenReturn(TaskEither.right(unit));
      when(() => fridge.updateItem(household, any(), any())).thenReturn(TaskEither.right(unit));
      return build();
    },
    act: (ScanCubit cubit) async {
      await cubit.start();
      cubit
        ..toggle(2)
        ..edit(
          1,
          FridgeItemInput(
            name: 'Lait entier',
            quantity: 2,
            unit: FridgeUnit.liter,
            category: FridgeCategory.dairy,
            bestBefore: none(),
          ),
        );
      await cubit.save();
    },
    skip: 5,
    expect: () => <Matcher>[isA<ScanSaving>(), isA<ScanSaved>().having((ScanSaved state) => state.count, 'count', 2)],
    verify: (_) {
      verify(
        () => fridge.updateItem(
          household,
          storedTomatoes.id,
          any(that: isA<FridgeItemInput>().having((FridgeItemInput input) => input.quantity, 'quantity', 5)),
        ),
      ).called(1);
      verify(
        () => fridge.addItem(
          household,
          any(that: isA<FridgeItemInput>().having((FridgeItemInput input) => input.name, 'name', 'Lait entier')),
        ),
      ).called(1);
    },
  );

  blocTest<ScanCubit, ScanState>(
    'drops a removed ingredient from the review',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => scan.recognizeIngredients(photo)).thenReturn(TaskEither.right(<ScanProposal>[tomatoes, milk]));
      return build();
    },
    act: (ScanCubit cubit) async {
      await cubit.start();
      cubit.remove(0);
    },
    skip: 3,
    expect: () => <Matcher>[
      isA<ScanReview>().having(
        (ScanReview state) => state.lines.map((ScanLine line) => line.input.name),
        'names',
        <String>['Lait'],
      ),
    ],
  );

  blocTest<ScanCubit, ScanState>(
    'checks or unchecks every ingredient at once',
    build: () {
      when(() => scan.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => scan.recognizeIngredients(photo)).thenReturn(TaskEither.right(<ScanProposal>[tomatoes, milk]));
      return build();
    },
    act: (ScanCubit cubit) async {
      await cubit.start();
      cubit
        ..toggle(0)
        ..selectAll()
        ..selectAll();
    },
    skip: 4,
    expect: () => <Matcher>[
      isA<ScanReview>().having((ScanReview state) => state.allSelected, 'all selected', isTrue),
      isA<ScanReview>().having((ScanReview state) => state.selectedLines, 'selected', isEmpty),
    ],
  );
}
