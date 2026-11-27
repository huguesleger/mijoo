part of 'package:mijoo/core/router/routes.dart';

class MealsPageRoute extends GoRouteData with $MealsPageRoute {
  const MealsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => household.profile.match(
      () => const LaunchScreen(),
      (HouseholdProfile profile) => BlocProvider<MealsCubit>(
        create: (_) => MealsCubit(household: household.id, profile: profile)..watch(),
        child: MealsScreen(profile: profile),
      ),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
