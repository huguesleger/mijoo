import 'package:fpdart/fpdart.dart';

import 'session_cubit.dart';

const launchPath = '/launch';
const welcomePath = '/';
const homePath = '/home';
const signInPath = '/sign-in';
const registerPath = '/register';
const forgotPasswordPath = '/forgot-password';

const _publicPaths = {
  welcomePath,
  signInPath,
  registerPath,
  forgotPasswordPath,
};

Option<String> sessionRedirect(SessionState session, String location) =>
    switch (session) {
      SessionUnknown() => location == launchPath ? none() : some(launchPath),
      SignedOut() =>
        _publicPaths.contains(location) ? none() : some(welcomePath),
      SignedIn() =>
        _publicPaths.contains(location) || location == launchPath
            ? some(homePath)
            : none(),
    };
