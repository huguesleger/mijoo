import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/fridge/data/data_sources/firestore_fridge_data_source.dart';
import 'package:mijoo/features/fridge/data/mappers/fridge_item_mapper.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';

final class FridgeRepositoryImpl implements FridgeRepository {
  const FridgeRepositoryImpl(this._source);

  final FirestoreFridgeDataSource _source;

  @override
  Stream<Either<AppFailure, List<FridgeItem>>> watchItems(HouseholdId household) => _source
      .watchItems(household.value)
      .map(
        (Either<AppFailure, List<FridgeItemSnapshot>> result) => result.map(
          (List<FridgeItemSnapshot> snapshots) => <FridgeItem>[
            for (final FridgeItemSnapshot snapshot in snapshots) firestoreToFridgeItem(snapshot.id, snapshot.data),
          ],
        ),
      );

  @override
  TaskEither<AppFailure, Unit> addItem(HouseholdId household, FridgeItemInput input) =>
      _source.addItem(household.value, fridgeItemInputToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> updateItem(HouseholdId household, FridgeItemId item, FridgeItemInput input) =>
      _source.updateItem(household.value, item.value, fridgeItemInputToFirestore(input));

  @override
  TaskEither<AppFailure, Unit> deleteItem(HouseholdId household, FridgeItemId item) =>
      _source.deleteItem(household.value, item.value);
}
