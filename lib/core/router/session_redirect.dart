import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/router/route_paths.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';

const Set<String> _publicPaths = <String>{
  welcomePath,
  signInPath,
  registerPath,
  forgotPasswordPath,
};

Option<String> sessionRedirect(SessionState session, String location) => switch (session) {
  SessionUnknown() => _stayOn(launchPath, location),
  SignedOut() => _publicPaths.contains(location) ? none() : some(welcomePath),
  SignedIn(:final household) => switch (household) {
    HouseholdLoading() => _stayOn(launchPath, location),
    HouseholdMissing() => _stayOn(setupPath, location),
    HouseholdFound(:final household) => household.profile.match(
      () => _stayOn(setupPath, location),
      (_) => _publicPaths.contains(location) || location == launchPath ? some(homePath) : none(),
    ),
  },
};

Option<String> _stayOn(String path, String location) => location == path ? none() : some(path);
