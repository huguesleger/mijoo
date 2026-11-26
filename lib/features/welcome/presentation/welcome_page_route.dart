import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../session/presentation/session_redirect.dart';
import 'welcome_cubit.dart';
import 'welcome_screen.dart';

final welcomePageRoute = GoRoute(
  path: welcomePath,
  builder: (_, _) =>
      BlocProvider(create: (_) => WelcomeCubit(), child: const WelcomeScreen()),
);
