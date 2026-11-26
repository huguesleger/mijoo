part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<SetupPageRoute>(path: setupPath, name: 'setup')
class SetupPageRoute extends GoRouteData with $SetupPageRoute {
  const SetupPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(:final account, :final household) => BlocProvider<SetupCubit>(
      create: (_) => SetupCubit(
        account: account.id,
        household: switch (household) {
          HouseholdFound(:final household) => some(household.id),
          HouseholdLoading() || HouseholdMissing() => none(),
        },
      ),
      child: const SetupScreen(),
    ),
    SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
