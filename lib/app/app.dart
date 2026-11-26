import 'package:mijoo/core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/app_router.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final SessionCubit _session = SessionCubit();
  late final GoRouter _router = buildAppRouter(_session);

  @override
  void dispose() {
    _router.dispose();
    _session.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<SessionCubit>.value(
    value: _session,
    child: MaterialApp.router(
      title: t.welcome.appName,
      debugShowCheckedModeBanner: false,
      theme: DsTheme.light(),
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: _router,
    ),
  );
}
