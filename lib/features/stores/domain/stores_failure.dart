import 'package:mijoo/core/core.dart';

final class StoresNetworkFailure extends AppFailure {
  const StoresNetworkFailure();
}

final class StoresBusy extends AppFailure {
  const StoresBusy();
}

final class StoresTownNotFound extends AppFailure {
  const StoresTownNotFound();
}

final class StoresLocationOff extends AppFailure {
  const StoresLocationOff();
}

final class StoresLocationDenied extends AppFailure {
  const StoresLocationDenied();
}
