import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/rules/invite_codes.dart';

void main() {
  test('creates codes of six unambiguous characters', () {
    final codes = List.generate(200, (_) => newInviteCode(Random(42)).value);
    for (final code in codes) {
      expect(code.length, inviteLength);
      expect(code.split('').every(inviteAlphabet.contains), isTrue);
      expect(code.contains(RegExp('[01IOL]')), isFalse);
    }
  });

  test('reads a code typed loosely', () {
    expect(parseInviteCode('mj-4k7q'), some(const InviteCode('MJ4K7Q')));
    expect(parseInviteCode(' MJ 4K7Q '), some(const InviteCode('MJ4K7Q')));
    expect(parseInviteCode('MJ4K7'), isA<None>());
    expect(parseInviteCode('MJ4K7O'), isA<None>());
  });

  test('shows the code in two parts', () {
    expect(displayInviteCode(const InviteCode('MJ4K7Q')), 'MJ-4K7Q');
  });
}
