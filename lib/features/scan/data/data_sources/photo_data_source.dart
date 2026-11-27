import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';

final class PhotoDataSource {
  PhotoDataSource([ImagePicker? picker]) : _picker = picker ?? ImagePicker();

  static const double maxSide = 1280;
  static const int quality = 80;

  final ImagePicker _picker;

  TaskEither<AppFailure, Option<Uint8List>> takePhoto(PhotoSource source) =>
      TaskEither<AppFailure, Option<Uint8List>>.tryCatch(
        () async => switch (await _picker.pickImage(
          source: switch (source) {
            PhotoSource.camera => ImageSource.camera,
            PhotoSource.gallery => ImageSource.gallery,
          },
          maxWidth: maxSide,
          maxHeight: maxSide,
          imageQuality: quality,
          requestFullMetadata: false,
        )) {
          final XFile file => some(await file.readAsBytes()),
          null => none(),
        },
        (Object error, StackTrace stack) {
          log('photo', name: 'mijoo.scan', stackTrace: stack);
          return switch (error) {
            PlatformException(code: 'camera_access_denied' || 'photo_access_denied') => const ScanCameraDenied(),
            _ => const ScanPhotoFailure(),
          };
        },
      );
}
