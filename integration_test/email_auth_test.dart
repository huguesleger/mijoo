import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/ds_back_button.dart';
import 'package:mijoo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('register, sign out and sign in to the same Firebase account', (
    tester,
  ) async {
    final random = Random.secure();
    final suffix = List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    final email = 'mijoo-test-$suffix@example.com';
    final password =
        'Mj!9${List.generate(20, (_) => random.nextInt(36).toRadixString(36)).join()}';
    app.main();
    await tester.pumpAndSettle();
    tester.testTextInput.register();
    await tester.tap(find.text(t.auth.register));
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Test Mijoo');
    await tester.enterText(fields.at(1), email);
    await tester.enterText(fields.at(2), password);
    await tester.enterText(fields.at(3), password);
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, t.auth.registerSubmit));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 150),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 90),
    );
    final auth = FirebaseAuth.instance;
    addTearDown(() async {
      final user = auth.currentUser;
      if (user?.email == email) await user!.delete();
    });
    expect(find.text(t.auth.signedIn), findsOneWidget);
    expect(find.text(email), findsOneWidget);
    final uid = auth.currentUser!.uid;
    await tester.tap(find.text(t.auth.signOut));
    await tester.pumpAndSettle();
    expect(auth.currentUser, isNull);
    await tester.tap(find.byType(DsBackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.auth.signIn));
    await tester.pumpAndSettle();
    await tester.enterText(fields.first, email);
    await tester.enterText(fields.last, password);
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, t.auth.signIn));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 150),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 90),
    );
    expect(find.text(t.auth.signedIn), findsOneWidget);
    expect(find.text(email), findsOneWidget);
    expect(auth.currentUser!.uid, uid);
  });
}
