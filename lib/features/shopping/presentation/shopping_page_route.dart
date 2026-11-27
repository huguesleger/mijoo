part of 'package:mijoo/core/router/routes.dart';

class ShoppingPageRoute extends GoRouteData with $ShoppingPageRoute {
  const ShoppingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(:final account, household: HouseholdFound(:final household)) => BlocProvider<ShoppingCubit>(
      create: (_) => ShoppingCubit(
        household: household.id,
        author: account.name.getOrElse(() => account.email.split('@').first),
        budgetCents: household.profile.flatMap((HouseholdProfile profile) => profile.weeklyBudgetCents),
      )..watch(),
      child: const ShoppingScreen(),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
