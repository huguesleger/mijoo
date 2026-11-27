import 'package:mijoo/features/auth/domain/entities/account.dart';

final class HouseholdMember {
  const HouseholdMember({required this.id, required this.name});

  final AccountId id;
  final String name;
}
