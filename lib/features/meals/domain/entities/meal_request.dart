import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';

final class MealRequest {
  const MealRequest({
    required this.profile,
    required this.items,
    required this.toFinishFirst,
    required this.craving,
    required this.recentTitles,
  });

  final HouseholdProfile profile;
  final List<FridgeItem> items;
  final List<FridgeItem> toFinishFirst;
  final MealCraving craving;
  final List<String> recentTitles;
}
