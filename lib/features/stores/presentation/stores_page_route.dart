part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<StoresPageRoute>(path: storesPath, name: 'stores')
class StoresPageRoute extends GoRouteData with $StoresPageRoute {
  const StoresPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => BlocProvider<StoresCubit>(
      create: (_) => StoresCubit(
        town: household.profile.flatMap((HouseholdProfile profile) => profile.location),
      )..search(),
      child: const StoresScreen(),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
