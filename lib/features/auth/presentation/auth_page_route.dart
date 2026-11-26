part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<SignInPageRoute>(path: signInPath, name: 'signIn')
class SignInPageRoute extends GoRouteData with $SignInPageRoute {
  const SignInPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider<AuthCubit>(
    create: (_) => AuthCubit(mode: const SignInMode()),
    child: const AuthScreen(),
  );
}

@TypedGoRoute<RegisterPageRoute>(path: registerPath, name: 'register')
class RegisterPageRoute extends GoRouteData with $RegisterPageRoute {
  const RegisterPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider<AuthCubit>(
    create: (_) => AuthCubit(mode: const RegisterMode()),
    child: const AuthScreen(),
  );
}
