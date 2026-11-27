part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<AccountPageRoute>(path: accountPath, name: 'account')
class AccountPageRoute extends GoRouteData with $AccountPageRoute {
  const AccountPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(:final account, household: HouseholdFound(:final household)) => MultiBlocProvider(
      providers: <BlocProvider<Object?>>[
        BlocProvider<AccountCubit>(create: (_) => AccountCubit(account: account)),
        BlocProvider<HouseholdMembersCubit>(
          create: (_) =>
              HouseholdMembersCubit(
                  household: household.id,
                  me: HouseholdMember(
                    id: account.id,
                    name: account.name.getOrElse(() => account.email.split('@').first),
                  ),
                )
                ..watch()
                ..introduceMe(),
        ),
      ],
      child: const AccountScreen(),
    ),
    SignedIn(:final account) => BlocProvider<AccountCubit>(
      create: (_) => AccountCubit(account: account),
      child: const AccountScreen(),
    ),
    SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
