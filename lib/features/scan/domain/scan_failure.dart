import 'package:mijoo/core/core.dart';

final class ScanUnavailable extends AppFailure {
  const ScanUnavailable();
}

final class ScanNetworkFailure extends AppFailure {
  const ScanNetworkFailure();
}

final class ScanQuotaReached extends AppFailure {
  const ScanQuotaReached();
}

final class ScanInvalidResponse extends AppFailure {
  const ScanInvalidResponse();
}

final class ScanPhotoFailure extends AppFailure {
  const ScanPhotoFailure();
}

final class ProductLookupFailure extends AppFailure {
  const ProductLookupFailure();
}

final class ScanCameraDenied extends AppFailure {
  const ScanCameraDenied();
}

final class ScanBusy extends AppFailure {
  const ScanBusy();
}
