part of 'package:mijoo/features/scan/presentation/bloc/barcode_cubit.dart';

@immutable
sealed class BarcodeState {
  const BarcodeState();
}

final class BarcodeScanning extends BarcodeState {
  const BarcodeScanning();
}

final class BarcodeSearching extends BarcodeState {
  const BarcodeSearching();
}

final class BarcodeFound extends BarcodeState {
  const BarcodeFound(this.product);

  final ScanProposal product;
}

final class BarcodeNotFound extends BarcodeState {
  const BarcodeNotFound();
}

final class BarcodeFailed extends BarcodeState {
  const BarcodeFailed(this.failure);

  final AppFailure failure;
}
