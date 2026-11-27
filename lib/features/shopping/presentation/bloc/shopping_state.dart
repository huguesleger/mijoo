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
  const ShoppingLoaded({required this.facts, required this.writeFailure});

  final ShoppingFacts facts;
  final Option<AppFailure> writeFailure;

  ShoppingLoaded copyWith({Option<AppFailure>? writeFailure}) =>
      ShoppingLoaded(facts: facts, writeFailure: writeFailure ?? this.writeFailure);
}
