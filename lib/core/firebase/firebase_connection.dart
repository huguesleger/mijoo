import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:mijoo/core/firebase/firebase_options.dart';

class FirebaseConnection {
  static const _projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const _appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const _apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const _sender = String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const _useEmulator = bool.fromEnvironment('FIREBASE_EMULATOR');
  static const _emulatorHost = String.fromEnvironment('FIREBASE_EMULATOR_HOST');

  bool get _hasOverrides => [_projectId, _appId, _apiKey, _sender].every((value) => value.isNotEmpty);

  bool get isConfigured =>
      _useEmulator ||
      _hasOverrides ||
      (!kIsWeb &&
          [
            TargetPlatform.android,
            TargetPlatform.iOS,
          ].contains(defaultTargetPlatform));

  late final Future<FirebaseAuth> auth = _app.then((app) async {
    final auth = FirebaseAuth.instanceFor(app: app);
    if (_useEmulator) await auth.useAuthEmulator(_emulatorHostName, 9099);
    return auth;
  });

  late final Future<FirebaseFirestore> firestore = _app.then((app) {
    final firestore = FirebaseFirestore.instanceFor(app: app);
    if (_useEmulator) firestore.useFirestoreEmulator(_emulatorHostName, 8080);
    return firestore;
  });

  late final Future<FirebaseApp> _app = Firebase.initializeApp(
    options: _useEmulator
        ? DefaultFirebaseOptions.currentPlatform.copyWith(
            projectId: 'demo-mijoo',
          )
        : _hasOverrides
        ? const FirebaseOptions(
            apiKey: _apiKey,
            appId: _appId,
            messagingSenderId: _sender,
            projectId: _projectId,
          )
        : DefaultFirebaseOptions.currentPlatform,
  );

  String get _emulatorHostName => _emulatorHost.isNotEmpty
      ? _emulatorHost
      : defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2'
      : 'localhost';
}
