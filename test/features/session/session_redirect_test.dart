import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/account.dart';
import 'package:mijoo/features/session/presentation/session_cubit.dart';
import 'package:mijoo/features/session/presentation/session_redirect.dart';

void main() {
  const account = Account(
    id: AccountId('example'),
    email: 'camille@example.test',
    name: None(),
  );

  test('waits on the launch screen while the session is unknown', () {
    expect(
      sessionRedirect(const SessionUnknown(), welcomePath),
      some(launchPath),
    );
    expect(sessionRedirect(const SessionUnknown(), launchPath), none<String>());
  });

  test('keeps a signed-out user on public screens', () {
    expect(sessionRedirect(const SignedOut(), launchPath), some(welcomePath));
    expect(sessionRedirect(const SignedOut(), homePath), some(welcomePath));
    for (final path in [
      welcomePath,
      signInPath,
      registerPath,
      forgotPasswordPath,
    ]) {
      expect(sessionRedirect(const SignedOut(), path), none<String>());
    }
  });

  test('sends a signed-in user to the home screen', () {
    for (final path in [launchPath, welcomePath, signInPath, registerPath]) {
      expect(sessionRedirect(const SignedIn(account), path), some(homePath));
    }
    expect(
      sessionRedirect(const SignedIn(account), '/account'),
      none<String>(),
    );
  });
}
