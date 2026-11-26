import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';

class FirebaseConnection {
  static const _projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const _appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const _apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const _sender = String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const _useEmulator = bool.fromEnvironment('FIREBASE_EMULATOR');
  static const _emulatorHost = String.fromEnvironment('FIREBASE_EMULATOR_HOST');

  bool get _hasOverrides =>
      [_projectId, _appId, _apiKey, _sender].every((value) => value.isNotEmpty);

  bool get isConfigured =>
      _useEmulator ||
      _hasOverrides ||
      (!kIsWeb &&
          [
            TargetPlatform.android,
            TargetPlatform.iOS,
          ].contains(defaultTargetPlatform));

  Future<FirebaseAuth> connect() async {
    final app = _useEmulator
        ? await Firebase.initializeApp(demoProjectId: 'demo-mijoo')
        : await Firebase.initializeApp(
            options: _hasOverrides
                ? const FirebaseOptions(
                    apiKey: _apiKey,
                    appId: _appId,
                    messagingSenderId: _sender,
                    projectId: _projectId,
                  )
                : DefaultFirebaseOptions.currentPlatform,
          );
    final auth = FirebaseAuth.instanceFor(app: app);
    if (_useEmulator) {
      final platformHost = defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2'
          : 'localhost';
      await auth.useAuthEmulator(
        _emulatorHost.isEmpty ? platformHost : _emulatorHost,
        9099,
      );
    }
    return auth;
  }
}
