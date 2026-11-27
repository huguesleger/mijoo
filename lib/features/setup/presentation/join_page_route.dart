part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<JoinPageRoute>(path: joinPath, name: 'join')
class JoinPageRoute extends GoRouteData with $JoinPageRoute {
  const JoinPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(:final account) => BlocProvider<JoinCubit>(
      create: (_) => JoinCubit(
        me: HouseholdMember(id: account.id, name: account.name.getOrElse(() => account.email.split('@').first)),
      ),
      child: const JoinScreen(),
    ),
    SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
