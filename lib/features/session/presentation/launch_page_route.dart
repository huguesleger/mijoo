part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<LaunchPageRoute>(path: launchPath, name: 'launch')
class LaunchPageRoute extends GoRouteData with $LaunchPageRoute {
  const LaunchPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LaunchScreen();
}
