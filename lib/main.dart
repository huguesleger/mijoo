import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app_router.dart';
import 'core/firebase/firebase_connection.dart';
import 'core/i18n/translations.g.dart';
import 'features/auth/data/firebase_auth_repository.dart';
import 'features/auth/data/firebase_auth_source.dart';
import 'features/auth/domain/auth_repository.dart';
import 'features/session/presentation/session_cubit.dart';
import 'mijoo_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(FirebaseAuthSource(FirebaseConnection())),
  );
  final session = SessionCubit();
  runApp(
    TranslationProvider(
      child: BlocProvider.value(
        value: session,
        child: MijooApp(router: buildAppRouter(session)),
      ),
    ),
  );
}
