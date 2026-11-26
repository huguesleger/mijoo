import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/auth/data/firebase_auth_repository.dart';
import 'package:mijoo/features/auth/data/firebase_auth_source.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/presentation/auth_page_route.dart';
import 'package:mijoo/features/welcome/presentation/welcome_page_route.dart';
import 'package:mijoo/mijoo_app.dart';

void main() {
  testWidgets(
    'welcome opens both auth forms and explains missing Firebase configuration',
    (tester) async {
      GetIt.I.registerSingleton<AuthRepository>(
        FirebaseAuthRepository(FirebaseAuthSource(FirebaseConnection())),
      );
      addTearDown(GetIt.I.reset);
      final router = GoRouter(routes: [welcomePageRoute, ...authPageRoutes]);
      addTearDown(router.dispose);

      await tester.pumpWidget(
        TranslationProvider(child: MijooApp(router: router)),
      );
      await tester.pumpAndSettle();
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

      await tester.tap(find.byType(BackButton));
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
