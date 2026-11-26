import 'package:mijoo/core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/core/router/route_paths.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mijoo/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets(
    'welcome opens both auth forms and explains missing Firebase configuration',
    (tester) async {
      getIt.registerSingleton<AuthRepository>(
        AuthRepositoryImpl(FirebaseAuthDataSource(FirebaseConnection())),
      );
      addTearDown(getIt.reset);
      await pumpApp(tester, location: welcomePath);
      expect(
        find.text(
          t.welcome.titleLead + t.welcome.titleHighlight,
          findRichText: true,
        ),
        findsOneWidget,
      );
      await tester.tap(find.text(t.auth.register));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(4));

      await tester.tap(find.byType(DsBackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.auth.signIn));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(2));
      await tester.enterText(
        find.byType(TextFormField).first,
        'camille@example.test',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password-test');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, t.auth.signIn));
      await tester.pumpAndSettle();
      expect(find.text(t.auth.firebaseUnavailable), findsOneWidget);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.linux),
  );
}
