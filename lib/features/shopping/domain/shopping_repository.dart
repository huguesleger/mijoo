import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';

abstract interface class ShoppingRepository {
  Stream<Either<AppFailure, List<ShoppingEntry>>> watchEntries(HouseholdId household);
  TaskEither<AppFailure, Unit> addEntry(HouseholdId household, ShoppingEntryInput input);
  TaskEither<AppFailure, Unit> saveEntry(HouseholdId household, ShoppingEntryId entry, ShoppingEntryInput input);
  TaskEither<AppFailure, Unit> deleteEntries(HouseholdId household, List<ShoppingEntryId> entries);
}
