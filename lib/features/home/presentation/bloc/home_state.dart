part of 'package:mijoo/features/home/presentation/bloc/home_cubit.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.finishFirst, required this.today});

  final List<FridgeItem> finishFirst;
  final DateTime today;
}

final class HomeFailed extends HomeState {
  const HomeFailed(this.failure);

  final AppFailure failure;
}
