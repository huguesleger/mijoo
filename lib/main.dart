import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'core/firebase/firebase_connection.dart';
import 'core/i18n/translations.g.dart';
import 'features/auth/data/firebase_auth_repository.dart';
import 'features/auth/data/firebase_auth_source.dart';
import 'features/auth/domain/auth_repository.dart';
import 'features/auth/presentation/auth_page_route.dart';
import 'features/welcome/presentation/welcome_page_route.dart';
import 'mijoo_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(FirebaseAuthSource(FirebaseConnection())),
  );
  final router = GoRouter(routes: [welcomePageRoute, ...authPageRoutes]);
  runApp(TranslationProvider(child: MijooApp(router: router)));
}
