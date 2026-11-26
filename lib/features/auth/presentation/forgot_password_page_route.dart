part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<ForgotPasswordPageRoute>(path: forgotPasswordPath, name: 'forgotPassword')
class ForgotPasswordPageRoute extends GoRouteData with $ForgotPasswordPageRoute {
  const ForgotPasswordPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<ForgotPasswordCubit>(create: (_) => ForgotPasswordCubit(), child: const ForgotPasswordScreen());
}
