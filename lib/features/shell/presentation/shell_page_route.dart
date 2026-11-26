import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../session/presentation/session_redirect.dart';
import 'shell_home_screen.dart';
import 'shell_screen.dart';
import 'shell_tab_screen.dart';

const fridgePath = '/fridge';
const mealsPath = '/meals';
const shoppingPath = '/shopping';

final shellPageRoute = StatefulShellRoute.indexedStack(
  builder: (_, _, navigationShell) =>
      ShellScreen(navigationShell: navigationShell),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(path: homePath, builder: (_, _) => const ShellHomeScreen()),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: fridgePath,
          builder: (_, _) => ShellTabScreen(title: t.shell.fridge),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: mealsPath,
          builder: (_, _) => ShellTabScreen(title: t.shell.meals),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: shoppingPath,
          builder: (_, _) => ShellTabScreen(title: t.shell.shopping),
        ),
      ],
    ),
  ],
);
