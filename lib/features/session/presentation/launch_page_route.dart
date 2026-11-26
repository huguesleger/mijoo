import 'package:go_router/go_router.dart';

import 'launch_screen.dart';
import 'session_redirect.dart';

final launchPageRoute = GoRoute(
  path: launchPath,
  builder: (_, _) => const LaunchScreen(),
);
