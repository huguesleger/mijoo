import 'package:go_router/go_router.dart';
import 'package:mijoo/core/router/route_paths.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core/router/session_redirect.dart';
import 'package:mijoo/core/router/stream_listenable.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';

GoRouter buildAppRouter(SessionCubit session) => GoRouter(
  initialLocation: launchPath,
  refreshListenable: StreamListenable(session.stream),
  redirect: (_, GoRouterState state) => sessionRedirect(session.state, state.matchedLocation).toNullable(),
  routes: $appRoutes,
);
