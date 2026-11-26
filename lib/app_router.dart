import 'package:go_router/go_router.dart';

import 'core/presentation/stream_listenable.dart';
import 'features/account/presentation/account_page_route.dart';
import 'features/auth/presentation/auth_page_route.dart';
import 'features/session/presentation/launch_page_route.dart';
import 'features/session/presentation/session_cubit.dart';
import 'features/session/presentation/session_redirect.dart';
import 'features/shell/presentation/shell_page_route.dart';
import 'features/welcome/presentation/welcome_page_route.dart';

GoRouter buildAppRouter(SessionCubit session) => GoRouter(
  initialLocation: launchPath,
  refreshListenable: StreamListenable(session.stream),
  redirect: (_, state) =>
      sessionRedirect(session.state, state.matchedLocation).toNullable(),
  routes: [
    launchPageRoute,
    welcomePageRoute,
    ...authPageRoutes,
    accountPageRoute,
    shellPageRoute,
  ],
);
