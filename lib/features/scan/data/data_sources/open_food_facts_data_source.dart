import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/scan/domain/scan_failure.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final class OpenFoodFactsDataSource {
  OpenFoodFactsDataSource() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Mijoo');
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[OpenFoodFactsLanguage.FRENCH];
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.FRANCE;
  }

  TaskEither<AppFailure, Option<Product>> findProduct(String barcode) =>
      TaskEither<AppFailure, Option<Product>>.tryCatch(
        () async => Option<Product>.fromNullable(
          (await OpenFoodAPIClient.getProductV3(
            ProductQueryConfiguration(
              barcode,
              version: ProductQueryVersion.latestVersion,
              language: OpenFoodFactsLanguage.FRENCH,
              fields: <ProductField>[
                ProductField.NAME,
                ProductField.NAME_IN_LANGUAGES,
                ProductField.GENERIC_NAME,
                ProductField.QUANTITY,
                ProductField.CATEGORIES_TAGS,
              ],
            ),
          )).product,
        ),
        (Object error, StackTrace stack) {
          log('product', name: 'mijoo.scan', stackTrace: stack);
          return const ProductLookupFailure();
        },
      );
}
