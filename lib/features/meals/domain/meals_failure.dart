import 'package:mijoo/core/core.dart';

final class MealsUnavailable extends AppFailure {
  const MealsUnavailable();
}

final class MealsNetworkFailure extends AppFailure {
  const MealsNetworkFailure();
}

final class MealsAccessDenied extends AppFailure {
  const MealsAccessDenied();
}

final class MealsBusy extends AppFailure {
  const MealsBusy();
}

final class MealsQuotaReached extends AppFailure {
  const MealsQuotaReached();
}

final class MealsInvalidResponse extends AppFailure {
  const MealsInvalidResponse();
}

final class MealsNothingSuitable extends AppFailure {
  const MealsNothingSuitable();
}
