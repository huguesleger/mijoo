import 'package:fpdart/fpdart.dart';

extension type const AccountId(String value) {}

final class Account {
  const Account({required this.id, required this.email, required this.name});

  final AccountId id;
  final String email;
  final Option<String> name;
}
