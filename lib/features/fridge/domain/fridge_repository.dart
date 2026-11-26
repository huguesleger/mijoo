import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';

abstract interface class FridgeRepository {
  Stream<Either<AppFailure, List<FridgeItem>>> watchItems(HouseholdId household);
  TaskEither<AppFailure, Unit> addItem(HouseholdId household, FridgeItemInput input);
  TaskEither<AppFailure, Unit> updateItem(HouseholdId household, FridgeItemId item, FridgeItemInput input);
  TaskEither<AppFailure, Unit> deleteItem(HouseholdId household, FridgeItemId item);
}
