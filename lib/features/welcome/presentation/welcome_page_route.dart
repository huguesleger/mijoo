part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<WelcomePageRoute>(path: welcomePath, name: 'welcome')
class WelcomePageRoute extends GoRouteData with $WelcomePageRoute {
  const WelcomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<WelcomeCubit>(create: (_) => WelcomeCubit(), child: const WelcomeScreen());
}
