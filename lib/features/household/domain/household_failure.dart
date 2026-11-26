import 'package:mijoo/core/core.dart';

final class HouseholdUnavailable extends AppFailure {
  const HouseholdUnavailable();
}

final class HouseholdAccessDenied extends AppFailure {
  const HouseholdAccessDenied();
}

final class HouseholdNetworkFailure extends AppFailure {
  const HouseholdNetworkFailure();
}
