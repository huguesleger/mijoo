import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/domain/entities/barcode.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/domain/product_repository.dart';

part 'package:mijoo/features/scan/presentation/bloc/barcode_state.dart';

final class BarcodeCubit extends SafeCubit<BarcodeState> {
  BarcodeCubit({ProductRepository? repository, Duration? minimalLoading})
    : _repository = repository ?? getIt.get<ProductRepository>(),
      _minimalLoading = minimalLoading ?? MjLoader.minDuration,
      super(const BarcodeScanning());

  final ProductRepository _repository;
  final Duration _minimalLoading;

  Future<void> lookUp(Barcode barcode) => switch (state) {
    BarcodeScanning() => _lookUp(barcode),
    BarcodeSearching() || BarcodeFound() || BarcodeNotFound() || BarcodeFailed() => Future<void>.value(),
  };

  void scanAgain() => emit(const BarcodeScanning());

  Future<void> _lookUp(Barcode barcode) {
    emit(const BarcodeSearching());
    return _repository
        .findByBarcode(barcode)
        .withMinimalDelay(_minimalLoading)
        .match<BarcodeState>(
          BarcodeFailed.new,
          (Option<ScanProposal> product) =>
              product.match<BarcodeState>(() => const BarcodeNotFound(), BarcodeFound.new),
        )
        .map(emit)
        .run();
  }
}
