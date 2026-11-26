import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../domain/account.dart';

Account firebaseUserToAccount(User user) => Account(
  id: AccountId(user.uid),
  email: Option.fromNullable(user.email).getOrElse(() => ''),
  name: Option.fromNullable(user.displayName),
);
