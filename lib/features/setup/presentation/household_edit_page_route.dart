part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<HouseholdEditPageRoute>(path: householdEditPath, name: 'householdEdit')
class HouseholdEditPageRoute extends GoRouteData with $HouseholdEditPageRoute {
  const HouseholdEditPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => household.profile.match(
      () => const LaunchScreen(),
      (HouseholdProfile profile) => BlocProvider<HouseholdEditCubit>(
        create: (_) => HouseholdEditCubit(household: household.id, profile: profile),
        child: const HouseholdEditScreen(),
      ),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
