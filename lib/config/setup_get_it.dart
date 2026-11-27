import 'package:get_it/get_it.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/core/firebase/gemini_generator.dart';
import 'package:mijoo/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:mijoo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/fridge/data/data_sources/firestore_fridge_data_source.dart';
import 'package:mijoo/features/fridge/data/repositories/fridge_repository_impl.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/data/data_sources/firestore_household_data_source.dart';
import 'package:mijoo/features/household/data/repositories/household_repository_impl.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/meals/data/data_sources/firestore_meals_data_source.dart';
import 'package:mijoo/features/meals/data/data_sources/gemini_meals_data_source.dart';
import 'package:mijoo/features/meals/data/data_sources/meal_db_photo_data_source.dart';
import 'package:mijoo/features/meals/data/repositories/meals_repository_impl.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/scan/data/data_sources/gemini_scan_data_source.dart';
import 'package:mijoo/features/shopping/data/data_sources/firestore_shopping_data_source.dart';
import 'package:mijoo/features/shopping/data/repositories/shopping_repository_impl.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/scan/data/data_sources/open_food_facts_data_source.dart';
import 'package:mijoo/features/scan/data/data_sources/photo_data_source.dart';
import 'package:mijoo/features/scan/data/repositories/product_repository_impl.dart';
import 'package:mijoo/features/scan/data/repositories/scan_repository_impl.dart';
import 'package:mijoo/features/scan/domain/product_repository.dart';
import 'package:mijoo/features/scan/domain/scan_repository.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() => getIt
  ..registerLazySingleton<FirebaseConnection>(FirebaseConnection.new)
  ..registerLazySingleton<GeminiGenerator>(() => GeminiGenerator(getIt.get()))
  ..registerLazySingleton<FirebaseAuthDataSource>(() => FirebaseAuthDataSource(getIt.get()))
  ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt.get()))
  ..registerLazySingleton<FirestoreHouseholdDataSource>(() => FirestoreHouseholdDataSource(getIt.get()))
  ..registerLazySingleton<HouseholdRepository>(() => HouseholdRepositoryImpl(getIt.get()))
  ..registerLazySingleton<FirestoreFridgeDataSource>(() => FirestoreFridgeDataSource(getIt.get()))
  ..registerLazySingleton<FridgeRepository>(() => FridgeRepositoryImpl(getIt.get()))
  ..registerLazySingleton<PhotoDataSource>(PhotoDataSource.new)
  ..registerLazySingleton<GeminiScanDataSource>(() => GeminiScanDataSource(getIt.get()))
  ..registerLazySingleton<ScanRepository>(() => ScanRepositoryImpl(getIt.get(), getIt.get()))
  ..registerLazySingleton<OpenFoodFactsDataSource>(OpenFoodFactsDataSource.new)
  ..registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(getIt.get()))
  ..registerLazySingleton<FirestoreMealsDataSource>(() => FirestoreMealsDataSource(getIt.get()))
  ..registerLazySingleton<GeminiMealsDataSource>(() => GeminiMealsDataSource(getIt.get()))
  ..registerLazySingleton<MealDbPhotoDataSource>(MealDbPhotoDataSource.new)
  ..registerLazySingleton<MealsRepository>(() => MealsRepositoryImpl(getIt.get(), getIt.get(), getIt.get()))
  ..registerLazySingleton<FirestoreShoppingDataSource>(() => FirestoreShoppingDataSource(getIt.get()))
  ..registerLazySingleton<ShoppingRepository>(() => ShoppingRepositoryImpl(getIt.get()));
