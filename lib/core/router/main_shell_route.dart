part of 'package:mijoo/core/router/routes.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<HomePageRoute>(path: homePath, name: 'home')],
    ),
    TypedStatefulShellBranch<FridgeBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<FridgePageRoute>(path: fridgePath, name: 'fridge')],
    ),
    TypedStatefulShellBranch<MealsBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<MealsPageRoute>(path: mealsPath, name: 'meals')],
    ),
    TypedStatefulShellBranch<ShoppingBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<ShoppingPageRoute>(path: shoppingPath, name: 'shopping')],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
      MainShell(navigationShell: navigationShell);
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class FridgeBranch extends StatefulShellBranchData {
  const FridgeBranch();
}

class MealsBranch extends StatefulShellBranchData {
  const MealsBranch();
}

class ShoppingBranch extends StatefulShellBranchData {
  const ShoppingBranch();
}

class FridgePageRoute extends GoRouteData with $FridgePageRoute {
  const FridgePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => TabPlaceholder(title: t.shell.fridge);
}

class MealsPageRoute extends GoRouteData with $MealsPageRoute {
  const MealsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => TabPlaceholder(title: t.shell.meals);
}

class ShoppingPageRoute extends GoRouteData with $ShoppingPageRoute {
  const ShoppingPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => TabPlaceholder(title: t.shell.shopping);
}
