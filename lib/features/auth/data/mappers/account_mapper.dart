import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/features/auth/domain/entities/account.dart';

Account firebaseUserToAccount(User user) => Account(
  id: AccountId(user.uid),
  email: Option.fromNullable(user.email).getOrElse(() => ''),
  name: Option.fromNullable(user.displayName),
);
