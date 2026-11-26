import 'package:fpdart/fpdart.dart';

final class HouseholdProfile {
  const HouseholdProfile({
    required this.adults,
    required this.children,
    required this.likes,
    required this.exclusions,
    required this.allergies,
    required this.maxPrepMinutes,
    required this.weeklyBudgetCents,
    required this.location,
  });

  final int adults;
  final int children;
  final List<String> likes;
  final List<String> exclusions;
  final List<String> allergies;
  final int maxPrepMinutes;
  final Option<int> weeklyBudgetCents;
  final Option<HouseholdLocation> location;

  int get people => adults + children;
}

final class HouseholdLocation {
  const HouseholdLocation({required this.postalCode, required this.city});

  final String postalCode;
  final String city;
}
