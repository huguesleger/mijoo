import 'package:mijoo/core/core.dart';

final class FridgeUnavailable extends AppFailure {
  const FridgeUnavailable();
}

final class FridgeAccessDenied extends AppFailure {
  const FridgeAccessDenied();
}

final class FridgeNetworkFailure extends AppFailure {
  const FridgeNetworkFailure();
}
