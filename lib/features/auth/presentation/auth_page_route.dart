import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'auth_cubit.dart';
import 'auth_mode.dart';
import 'auth_screen.dart';

const signInRouteName = 'sign-in';
const registerRouteName = 'register';

final authPageRoutes = [
  GoRoute(
    path: '/sign-in',
    name: signInRouteName,
    builder: (_, _) => BlocProvider(
      create: (_) => AuthCubit(mode: const SignInMode()),
      child: const AuthScreen(),
    ),
  ),
  GoRoute(
    path: '/register',
    name: registerRouteName,
    builder: (_, _) => BlocProvider(
      create: (_) => AuthCubit(mode: const RegisterMode()),
      child: const AuthScreen(),
    ),
  ),
];
