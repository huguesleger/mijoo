import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/scan_repository.dart';

part 'package:mijoo/features/scan/presentation/bloc/best_before_state.dart';

final class BestBeforeCubit extends SafeCubit<BestBeforeState> {
  BestBeforeCubit({ScanRepository? repository, Duration? minimalLoading})
    : _repository = repository ?? getIt.get<ScanRepository>(),
      _minimalLoading = minimalLoading ?? MjLoader.minDuration,
      super(const BestBeforeIdle());

  final ScanRepository _repository;
  final Duration _minimalLoading;

  Future<void> read() => _repository
      .takePhoto(PhotoSource.camera)
      .flatMap(
        (Option<Uint8List> photo) => photo.match(
          () => TaskEither<AppFailure, BestBeforeState>.right(const BestBeforeIdle()),
          (Uint8List photo) => TaskEither<AppFailure, BestBeforeState>.Do(($) async {
            emit(const BestBeforeReading());
            final Option<DateTime> date = await $(
              _repository.readBestBefore(photo).withMinimalDelay(_minimalLoading),
            );
            return date.match<BestBeforeState>(() => const BestBeforeNotFound(), BestBeforeRead.new);
          }),
        ),
      )
      .match<BestBeforeState>(BestBeforeFailed.new, identity)
      .map(emit)
      .run();
}
