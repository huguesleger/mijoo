import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';

abstract interface class ScanRepository {
  TaskEither<AppFailure, Option<Uint8List>> takePhoto(PhotoSource source);
  TaskEither<AppFailure, List<ScanProposal>> recognizeIngredients(Uint8List photo);
  TaskEither<AppFailure, Option<DateTime>> readBestBefore(Uint8List photo);
}
