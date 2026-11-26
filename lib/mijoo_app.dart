import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/i18n/translations.g.dart';
import 'core_ui/mijoo_theme.dart';

class MijooApp extends StatelessWidget {
  const MijooApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: t.welcome.appName,
    theme: mijooTheme,
    routerConfig: router,
    debugShowCheckedModeBanner: false,
    locale: TranslationProvider.of(context).flutterLocale,
    supportedLocales: AppLocaleUtils.supportedLocales,
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
  );
}
