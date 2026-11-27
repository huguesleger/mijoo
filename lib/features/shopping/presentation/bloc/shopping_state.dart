part of 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';

@immutable
sealed class ShoppingState {
  const ShoppingState();
}

final class ShoppingLoading extends ShoppingState {
  const ShoppingLoading();
}

final class ShoppingFailed extends ShoppingState {
  const ShoppingFailed(this.failure);

  final AppFailure failure;
}

final class ShoppingLoaded extends ShoppingState {
  const ShoppingLoaded({
    required this.week,
    required this.budgetCents,
    required this.today,
    required this.writeFailure,
  });

  final ShoppingWeek week;
  final Option<int> budgetCents;
  final DateTime today;
  final Option<AppFailure> writeFailure;

  ShoppingFacts get facts => week.facts;

  ShoppingLoaded copyWith({Option<AppFailure>? writeFailure}) => ShoppingLoaded(
    week: week,
    budgetCents: budgetCents,
    today: today,
    writeFailure: writeFailure ?? this.writeFailure,
  );
}
