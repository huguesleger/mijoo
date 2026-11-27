import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/scan/domain/entities/barcode.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';

abstract interface class ProductRepository {
  TaskEither<AppFailure, Option<ScanProposal>> findByBarcode(Barcode barcode);
}
