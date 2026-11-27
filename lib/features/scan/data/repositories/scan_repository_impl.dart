import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/scan/data/data_sources/gemini_scan_data_source.dart';
import 'package:mijoo/features/scan/data/data_sources/photo_data_source.dart';
import 'package:mijoo/features/scan/data/mappers/scan_proposal_mapper.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';
import 'package:mijoo/features/scan/domain/scan_repository.dart';

final class ScanRepositoryImpl implements ScanRepository {
  const ScanRepositoryImpl(this._photos, this._gemini);

  final PhotoDataSource _photos;
  final GeminiScanDataSource _gemini;

  @override
  TaskEither<AppFailure, Option<Uint8List>> takePhoto(PhotoSource source) => _photos.takePhoto(source);

  @override
  TaskEither<AppFailure, List<ScanProposal>> recognizeIngredients(Uint8List photo) => _gemini
      .recognizeIngredients(photo)
      .flatMap(
        (String json) => TaskEither<AppFailure, List<ScanProposal>>.fromOption(
          geminiToScanProposals(json),
          () => const ScanInvalidResponse(),
        ),
      );

  @override
  TaskEither<AppFailure, Option<DateTime>> readBestBefore(Uint8List photo) =>
      _gemini.readBestBefore(photo).map(geminiToBestBefore);
}
