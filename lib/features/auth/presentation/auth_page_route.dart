import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../session/presentation/session_redirect.dart';
import 'auth_cubit.dart';
import 'auth_mode.dart';
import 'auth_screen.dart';
import 'forgot_password_cubit.dart';
import 'forgot_password_screen.dart';

const signInRouteName = 'sign-in';
const registerRouteName = 'register';
const forgotPasswordRouteName = 'forgot-password';

final authPageRoutes = [
  GoRoute(
    path: signInPath,
    name: signInRouteName,
    builder: (_, _) => BlocProvider(
      create: (_) => AuthCubit(mode: const SignInMode()),
      child: const AuthScreen(),
    ),
  ),
  GoRoute(
    path: registerPath,
    name: registerRouteName,
    builder: (_, _) => BlocProvider(
      create: (_) => AuthCubit(mode: const RegisterMode()),
      child: const AuthScreen(),
    ),
  ),
  GoRoute(
    path: forgotPasswordPath,
    name: forgotPasswordRouteName,
    builder: (_, _) => BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: const ForgotPasswordScreen(),
    ),
  ),
];
