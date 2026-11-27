import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/shopping/data/data_sources/firestore_shopping_data_source.dart';
import 'package:mijoo/features/shopping/data/mappers/shopping_entry_mapper.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';

final class ShoppingRepositoryImpl implements ShoppingRepository {
  const ShoppingRepositoryImpl(this._firestore);

  final FirestoreShoppingDataSource _firestore;

  @override
  Stream<Either<AppFailure, List<ShoppingEntry>>> watchEntries(HouseholdId household) => _firestore
      .watchEntries(household.value)
      .map(
        (Either<AppFailure, List<ShoppingEntrySnapshot>> result) => result.map(
          (List<ShoppingEntrySnapshot> entries) => <ShoppingEntry>[
            for (final ShoppingEntrySnapshot entry in entries)
              if (firestoreToShoppingEntry(entry.id, entry.data).toNullable() case final ShoppingEntry parsed) parsed,
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> addEntry(HouseholdId household, ShoppingEntryInput input) =>
      _firestore.addEntry(household.value, shoppingEntryToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> saveEntry(HouseholdId household, ShoppingEntryId entry, ShoppingEntryInput input) =>
      _firestore.saveEntry(household.value, entry.value, shoppingEntryToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> deleteEntries(HouseholdId household, List<ShoppingEntryId> entries) =>
      _firestore.deleteEntries(household.value, <String>[for (final ShoppingEntryId entry in entries) entry.value]);
}
