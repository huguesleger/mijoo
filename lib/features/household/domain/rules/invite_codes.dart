import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';

const String inviteAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
const int inviteLength = 6;
const Duration inviteLifetime = Duration(hours: 48);

InviteCode newInviteCode(Random random) => InviteCode(
  String.fromCharCodes(
    List<int>.generate(inviteLength, (_) => inviteAlphabet.codeUnitAt(random.nextInt(inviteAlphabet.length))),
  ),
);

Option<InviteCode> parseInviteCode(String input) {
  final String code = input.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');
  return code.length == inviteLength && code.split('').every(inviteAlphabet.contains) ? some(InviteCode(code)) : none();
}

String displayInviteCode(InviteCode code) => '${code.value.substring(0, 2)}-${code.value.substring(2)}';
