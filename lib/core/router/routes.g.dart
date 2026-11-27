// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $mainShellRoute,
  $accountPageRoute,
  $signInPageRoute,
  $registerPageRoute,
  $forgotPasswordPageRoute,
  $barcodePageRoute,
  $scanPageRoute,
  $launchPageRoute,
  $setupPageRoute,
  $welcomePageRoute,
];

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
  factory: $MainShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/home',
          name: 'home',
          hasOverriddenOnExit: false,
          factory: $HomePageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/fridge',
          name: 'fridge',
          hasOverriddenOnExit: false,
          factory: $FridgePageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/meals',
          name: 'meals',
          hasOverriddenOnExit: false,
          factory: $MealsPageRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/shopping',
          name: 'shopping',
          hasOverriddenOnExit: false,
          factory: $ShoppingPageRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) => const MainShellRoute();
}

mixin $HomePageRoute on GoRouteData {
  static HomePageRoute _fromState(GoRouterState state) => const HomePageRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FridgePageRoute on GoRouteData {
  static FridgePageRoute _fromState(GoRouterState state) => const FridgePageRoute();

  @override
  String get location => GoRouteData.$location('/fridge');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MealsPageRoute on GoRouteData {
  static MealsPageRoute _fromState(GoRouterState state) => const MealsPageRoute();

  @override
  String get location => GoRouteData.$location('/meals');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ShoppingPageRoute on GoRouteData {
  static ShoppingPageRoute _fromState(GoRouterState state) => const ShoppingPageRoute();

  @override
  String get location => GoRouteData.$location('/shopping');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountPageRoute => GoRouteData.$route(
  path: '/account',
  name: 'account',
  hasOverriddenOnExit: false,
  factory: $AccountPageRoute._fromState,
);

mixin $AccountPageRoute on GoRouteData {
  static AccountPageRoute _fromState(GoRouterState state) => const AccountPageRoute();

  @override
  String get location => GoRouteData.$location('/account');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInPageRoute => GoRouteData.$route(
  path: '/sign-in',
  name: 'signIn',
  hasOverriddenOnExit: false,
  factory: $SignInPageRoute._fromState,
);

mixin $SignInPageRoute on GoRouteData {
  static SignInPageRoute _fromState(GoRouterState state) => const SignInPageRoute();

  @override
  String get location => GoRouteData.$location('/sign-in');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerPageRoute => GoRouteData.$route(
  path: '/register',
  name: 'register',
  hasOverriddenOnExit: false,
  factory: $RegisterPageRoute._fromState,
);

mixin $RegisterPageRoute on GoRouteData {
  static RegisterPageRoute _fromState(GoRouterState state) => const RegisterPageRoute();

  @override
  String get location => GoRouteData.$location('/register');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $forgotPasswordPageRoute => GoRouteData.$route(
  path: '/forgot-password',
  name: 'forgotPassword',
  hasOverriddenOnExit: false,
  factory: $ForgotPasswordPageRoute._fromState,
);

mixin $ForgotPasswordPageRoute on GoRouteData {
  static ForgotPasswordPageRoute _fromState(GoRouterState state) => const ForgotPasswordPageRoute();

  @override
  String get location => GoRouteData.$location('/forgot-password');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $barcodePageRoute => GoRouteData.$route(
  path: '/barcode',
  name: 'barcode',
  hasOverriddenOnExit: false,
  factory: $BarcodePageRoute._fromState,
);

mixin $BarcodePageRoute on GoRouteData {
  static BarcodePageRoute _fromState(GoRouterState state) => const BarcodePageRoute();

  @override
  String get location => GoRouteData.$location('/barcode');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $scanPageRoute => GoRouteData.$route(
  path: '/scan',
  name: 'scan',
  hasOverriddenOnExit: false,
  factory: $ScanPageRoute._fromState,
);

mixin $ScanPageRoute on GoRouteData {
  static ScanPageRoute _fromState(GoRouterState state) => ScanPageRoute(
    source: _$PhotoSourceEnumMap._$fromName(
      state.uri.queryParameters['source']!,
    )!,
  );

  ScanPageRoute get _self => this as ScanPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/scan',
    queryParams: {'source': _$PhotoSourceEnumMap[_self.source]},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$PhotoSourceEnumMap = {
  PhotoSource.camera: 'camera',
  PhotoSource.gallery: 'gallery',
};

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) => entries.where((element) => element.value == value).firstOrNull?.key;
}

RouteBase get $launchPageRoute => GoRouteData.$route(
  path: '/launch',
  name: 'launch',
  hasOverriddenOnExit: false,
  factory: $LaunchPageRoute._fromState,
);

mixin $LaunchPageRoute on GoRouteData {
  static LaunchPageRoute _fromState(GoRouterState state) => const LaunchPageRoute();

  @override
  String get location => GoRouteData.$location('/launch');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $setupPageRoute => GoRouteData.$route(
  path: '/setup',
  name: 'setup',
  hasOverriddenOnExit: false,
  factory: $SetupPageRoute._fromState,
);

mixin $SetupPageRoute on GoRouteData {
  static SetupPageRoute _fromState(GoRouterState state) => const SetupPageRoute();

  @override
  String get location => GoRouteData.$location('/setup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $welcomePageRoute => GoRouteData.$route(
  path: '/',
  name: 'welcome',
  hasOverriddenOnExit: false,
  factory: $WelcomePageRoute._fromState,
);

mixin $WelcomePageRoute on GoRouteData {
  static WelcomePageRoute _fromState(GoRouterState state) => const WelcomePageRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
