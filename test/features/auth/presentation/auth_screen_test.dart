import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/route_paths.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  Future<void> openRegister(WidgetTester tester) async {
    getIt.registerSingleton<AuthRepository>(MockAuthRepository());
    addTearDown(getIt.reset);
    await pumpApp(tester, location: registerPath);
  }

  Finder field(int index) => find.byType(TextFormField).at(index);

  FilledButton submit(WidgetTester tester) => tester.widget<FilledButton>(
    find.widgetWithText(FilledButton, t.auth.registerSubmit),
  );

  testWidgets('shows the mismatch only when the confirmation diverges', (
    tester,
  ) async {
    await openRegister(tester);
    await tester.enterText(field(0), 'Camille');
    await tester.enterText(field(1), 'camille@example.test');
    await tester.enterText(field(2), 'Mijoo-2026');
    await tester.pump();
    expect(find.text(t.auth.passwordMismatch), findsNothing);

    await tester.enterText(field(3), 'Mijoo-20');
    await tester.pump();
    expect(find.text(t.auth.passwordMismatch), findsNothing);
    expect(submit(tester).onPressed, isNull);

    await tester.enterText(field(3), 'Mijoo-20x');
    await tester.pump();
    expect(find.text(t.auth.passwordMismatch), findsOneWidget);
    expect(submit(tester).onPressed, isNull);

    await tester.enterText(field(3), 'Mijoo-2026');
    await tester.pump();
    expect(find.text(t.auth.passwordMismatch), findsNothing);
    expect(submit(tester).onPressed, isNotNull);
  });

  testWidgets('checks the password rules as the user types', (tester) async {
    await openRegister(tester);
    final handle = tester.ensureSemantics();
    await tester.enterText(field(2), 'mijoo-2026');
    await tester.pump();
    expect(
      tester.getSemantics(find.bySemanticsLabel(t.auth.ruleUppercase)),
      isSemantics(hasCheckedState: true, isChecked: false),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel(t.auth.ruleDigit)),
      isSemantics(hasCheckedState: true, isChecked: true),
    );
    handle.dispose();
  });
}
