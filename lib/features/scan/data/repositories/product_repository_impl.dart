import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/scan/data/data_sources/open_food_facts_data_source.dart';
import 'package:mijoo/features/scan/data/mappers/product_mapper.dart';
import 'package:mijoo/features/scan/domain/entities/barcode.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/domain/product_repository.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._source);

  final OpenFoodFactsDataSource _source;

  @override
  TaskEither<AppFailure, Option<ScanProposal>> findByBarcode(Barcode barcode) =>
      _source.findProduct(barcode.value).map((Option<Product> product) => product.flatMap(openFoodFactsToScanProposal));
}
