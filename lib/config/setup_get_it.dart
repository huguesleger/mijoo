import 'package:get_it/get_it.dart';
import 'package:mijoo/core/firebase/firebase_connection.dart';
import 'package:mijoo/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:mijoo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/fridge/data/data_sources/firestore_fridge_data_source.dart';
import 'package:mijoo/features/fridge/data/repositories/fridge_repository_impl.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/data/data_sources/firestore_household_data_source.dart';
import 'package:mijoo/features/household/data/repositories/household_repository_impl.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() => getIt
  ..registerLazySingleton<FirebaseConnection>(FirebaseConnection.new)
  ..registerLazySingleton<FirebaseAuthDataSource>(() => FirebaseAuthDataSource(getIt.get()))
  ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt.get()))
  ..registerLazySingleton<FirestoreHouseholdDataSource>(() => FirestoreHouseholdDataSource(getIt.get()))
  ..registerLazySingleton<HouseholdRepository>(() => HouseholdRepositoryImpl(getIt.get()))
  ..registerLazySingleton<FirestoreFridgeDataSource>(() => FirestoreFridgeDataSource(getIt.get()))
  ..registerLazySingleton<FridgeRepository>(() => FridgeRepositoryImpl(getIt.get()));
