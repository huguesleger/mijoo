part of 'package:mijoo/core/router/routes.dart';

class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}
