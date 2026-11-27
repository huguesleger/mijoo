part of 'package:mijoo/core/router/routes.dart';

class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(household: household.id)..watch(),
      child: const HomeScreen(),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
