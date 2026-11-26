import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../session/presentation/launch_screen.dart';
import '../../session/presentation/session_cubit.dart';
import 'account_cubit.dart';
import 'account_screen.dart';

const accountPath = '/account';
const accountRouteName = 'account';

final accountPageRoute = GoRoute(
  path: accountPath,
  name: accountRouteName,
  builder: (context, _) => switch (context.read<SessionCubit>().state) {
    SignedIn(:final account) => BlocProvider(
      create: (_) => AccountCubit(account: account),
      child: const AccountScreen(),
    ),
    SessionUnknown() || SignedOut() => const LaunchScreen(),
  },
);
