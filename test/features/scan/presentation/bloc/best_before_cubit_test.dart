import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';
import 'package:mijoo/features/scan/domain/scan_repository.dart';
import 'package:mijoo/features/scan/presentation/bloc/best_before_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockScanRepository extends Mock implements ScanRepository {}

void main() {
  final Uint8List photo = Uint8List.fromList(<int>[1]);
  late MockScanRepository repository;

  setUp(() => repository = MockScanRepository());

  BestBeforeCubit build() => BestBeforeCubit(repository: repository, minimalLoading: Duration.zero);

  blocTest<BestBeforeCubit, BestBeforeState>(
    'reads the date printed on the package',
    build: () {
      when(() => repository.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => repository.readBestBefore(photo)).thenReturn(TaskEither.right(some(DateTime(2026, 12, 4))));
      return build();
    },
    act: (BestBeforeCubit cubit) => cubit.read(),
    expect: () => <Matcher>[
      isA<BestBeforeReading>(),
      isA<BestBeforeRead>().having((BestBeforeRead state) => state.date, 'date', DateTime(2026, 12, 4)),
    ],
  );

  blocTest<BestBeforeCubit, BestBeforeState>(
    'says when no date can be read',
    build: () {
      when(() => repository.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(some(photo)));
      when(() => repository.readBestBefore(photo)).thenReturn(TaskEither.right(none()));
      return build();
    },
    act: (BestBeforeCubit cubit) => cubit.read(),
    expect: () => <Matcher>[isA<BestBeforeReading>(), isA<BestBeforeNotFound>()],
  );

  blocTest<BestBeforeCubit, BestBeforeState>(
    'goes back to idle when the photo is cancelled',
    build: () {
      when(() => repository.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.right(none()));
      return build();
    },
    act: (BestBeforeCubit cubit) => cubit.read(),
    expect: () => <Matcher>[isA<BestBeforeIdle>()],
  );

  blocTest<BestBeforeCubit, BestBeforeState>(
    'shows the failure of the camera',
    build: () {
      when(() => repository.takePhoto(PhotoSource.camera)).thenReturn(TaskEither.left(const ScanCameraDenied()));
      return build();
    },
    act: (BestBeforeCubit cubit) => cubit.read(),
    expect: () => <Matcher>[isA<BestBeforeFailed>()],
  );
}
