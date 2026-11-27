part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<MealDetailPageRoute>(path: mealDetailPath, name: 'mealDetail')
class MealDetailPageRoute extends GoRouteData with $MealDetailPageRoute {
  const MealDetailPageRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => household.profile.match(
      () => const LaunchScreen(),
      (HouseholdProfile profile) => BlocProvider<MealDetailCubit>(
        create: (_) => MealDetailCubit(household: household.id, profile: profile, idea: MealIdeaId(id))..watch(),
        child: const MealDetailScreen(),
      ),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
