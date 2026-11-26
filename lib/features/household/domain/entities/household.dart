import 'package:fpdart/fpdart.dart';

import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

extension type const HouseholdId(String value) {}

final class Household {
  const Household({
    required this.id,
    required this.memberIds,
    required this.profile,
  });

  final HouseholdId id;
  final List<AccountId> memberIds;
  final Option<HouseholdProfile> profile;
}
