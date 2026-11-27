import 'package:mijoo/core/core.dart';

final class ShoppingUnavailable extends AppFailure {
  const ShoppingUnavailable();
}

final class ShoppingNetworkFailure extends AppFailure {
  const ShoppingNetworkFailure();
}

final class ShoppingAccessDenied extends AppFailure {
  const ShoppingAccessDenied();
}
