import 'package:flutter/widgets.dart';
import 'package:mijoo/app/app.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/i18n/translations.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(TranslationProvider(child: const App()));
}
