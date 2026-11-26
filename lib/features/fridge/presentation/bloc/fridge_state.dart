part of 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';

@immutable
sealed class FridgeState {
  const FridgeState();
}

final class FridgeLoading extends FridgeState {
  const FridgeLoading();
}

final class FridgeLoaded extends FridgeState {
  const FridgeLoaded({required this.items, required this.query, required this.writeFailure});

  final List<FridgeItem> items;
  final String query;
  final Option<AppFailure> writeFailure;

  FridgeLoaded copyWith({List<FridgeItem>? items, String? query, Option<AppFailure>? writeFailure}) => FridgeLoaded(
    items: items ?? this.items,
    query: query ?? this.query,
    writeFailure: writeFailure ?? this.writeFailure,
  );
}

final class FridgeFailed extends FridgeState {
  const FridgeFailed(this.failure);

  final AppFailure failure;
}
