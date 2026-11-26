import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';
import 'package:mijoo/core/router/route_paths.dart';
import 'package:mijoo/core/router/session_redirect.dart';

void main() {
  const account = Account(
    id: AccountId('camille'),
    email: 'camille@example.test',
    name: None(),
  );
  const profile = HouseholdProfile(
    adults: 2,
    children: 1,
    likes: [],
    exclusions: [],
    allergies: [],
    maxPrepMinutes: 30,
    weeklyBudgetCents: None(),
    location: None(),
  );
  SignedIn signedIn(HouseholdStatus household) => SignedIn(account, household);
  HouseholdFound found(Option<HouseholdProfile> profile) => HouseholdFound(
    Household(
      id: const HouseholdId('h1'),
      memberIds: const [AccountId('camille')],
      profile: profile,
    ),
  );

  test('waits on the launch screen while the session is unknown', () {
    expect(
      sessionRedirect(const SessionUnknown(), welcomePath),
      some(launchPath),
    );
    expect(sessionRedirect(const SessionUnknown(), launchPath), none<String>());
  });

  test('keeps a signed-out user on public screens', () {
    expect(sessionRedirect(const SignedOut(), homePath), some(welcomePath));
    expect(sessionRedirect(const SignedOut(), setupPath), some(welcomePath));
    for (final path in [
      welcomePath,
      signInPath,
      registerPath,
      forgotPasswordPath,
    ]) {
      expect(sessionRedirect(const SignedOut(), path), none<String>());
    }
  });

  test('waits for the household before choosing a screen', () {
    expect(
      sessionRedirect(signedIn(const HouseholdLoading()), signInPath),
      some(launchPath),
    );
  });

  test('sends a user without a configured household to the setup', () {
    for (final status in [const HouseholdMissing(), found(none())]) {
      expect(sessionRedirect(signedIn(status), homePath), some(setupPath));
      expect(sessionRedirect(signedIn(status), setupPath), none<String>());
    }
  });

  test('sends a configured household to the home screen', () {
    final ready = signedIn(found(some(profile)));
    for (final path in [launchPath, welcomePath, signInPath, registerPath]) {
      expect(sessionRedirect(ready, path), some(homePath));
    }
    expect(sessionRedirect(ready, '/account'), none<String>());
    expect(sessionRedirect(ready, setupPath), none<String>());
  });
}
