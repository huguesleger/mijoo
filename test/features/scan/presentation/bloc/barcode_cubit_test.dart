import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/domain/entities/barcode.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/domain/product_repository.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';
import 'package:mijoo/features/scan/presentation/bloc/barcode_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  const Barcode code = Barcode('3017620422003');
  const ScanProposal spread = ScanProposal(
    name: 'Pâte à tartiner',
    quantity: 400,
    unit: FridgeUnit.gram,
    category: FridgeCategory.grocery,
    confidence: ScanConfidence.sure,
  );
  late MockProductRepository repository;

  setUp(() => repository = MockProductRepository());

  BarcodeCubit build() => BarcodeCubit(repository: repository, minimalLoading: Duration.zero);

  blocTest<BarcodeCubit, BarcodeState>(
    'finds the product of the barcode once, even if the camera sees it again',
    build: () {
      when(() => repository.findByBarcode(code)).thenReturn(TaskEither.right(some(spread)));
      return build();
    },
    act: (BarcodeCubit cubit) => Future.wait(<Future<void>>[cubit.lookUp(code), cubit.lookUp(code)]),
    expect: () => <Matcher>[
      isA<BarcodeSearching>(),
      isA<BarcodeFound>().having((BarcodeFound state) => state.product.name, 'name', 'Pâte à tartiner'),
    ],
    verify: (_) => verify(() => repository.findByBarcode(code)).called(1),
  );

  blocTest<BarcodeCubit, BarcodeState>(
    'says when the product is unknown and scans again on demand',
    build: () {
      when(() => repository.findByBarcode(code)).thenReturn(TaskEither.right(none()));
      return build();
    },
    act: (BarcodeCubit cubit) async {
      await cubit.lookUp(code);
      cubit.scanAgain();
    },
    expect: () => <Matcher>[isA<BarcodeSearching>(), isA<BarcodeNotFound>(), isA<BarcodeScanning>()],
  );

  blocTest<BarcodeCubit, BarcodeState>(
    'shows the failure of the lookup',
    build: () {
      when(() => repository.findByBarcode(code)).thenReturn(TaskEither.left(const ProductLookupFailure()));
      return build();
    },
    act: (BarcodeCubit cubit) => cubit.lookUp(code),
    expect: () => <Matcher>[
      isA<BarcodeSearching>(),
      isA<BarcodeFailed>().having((BarcodeFailed state) => state.failure, 'failure', const ProductLookupFailure()),
    ],
  );
}
