part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<AccountPageRoute>(path: accountPath, name: 'account')
class AccountPageRoute extends GoRouteData with $AccountPageRoute {
  const AccountPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(:final account) => BlocProvider<AccountCubit>(
      create: (_) => AccountCubit(account: account),
      child: const AccountScreen(),
    ),
    SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
