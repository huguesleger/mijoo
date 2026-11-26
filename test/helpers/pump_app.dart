import 'package:mijoo/core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';

Future<void> pumpApp(WidgetTester tester, {required String location}) async {
  final GoRouter router = GoRouter(initialLocation: location, routes: $appRoutes);
  addTearDown(router.dispose);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp.router(
        theme: DsTheme.light(),
        locale: AppLocale.fr.flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}
