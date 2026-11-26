part of 'package:mijoo/core/router/routes.dart';

class FridgePageRoute extends GoRouteData with $FridgePageRoute {
  const FridgePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => BlocProvider<FridgeCubit>(
      create: (_) => FridgeCubit(household: household.id)..watch(),
      child: const FridgeScreen(),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
