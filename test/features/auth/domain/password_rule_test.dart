import 'package:flutter_test/flutter_test.dart';
import 'package:mijoo/features/auth/domain/password_rule.dart';

void main() {
  test('evaluates each password rule', () {
    expect(PasswordRule.minLength.isMetBy('abcdefg'), isFalse);
    expect(PasswordRule.minLength.isMetBy('abcdefgh'), isTrue);
    expect(PasswordRule.digit.isMetBy('abc'), isFalse);
    expect(PasswordRule.digit.isMetBy('abc1'), isTrue);
    expect(PasswordRule.uppercase.isMetBy('abc'), isFalse);
    expect(PasswordRule.uppercase.isMetBy('Ébc'), isTrue);
    expect(PasswordRule.special.isMetBy('abc 1é'), isFalse);
    expect(PasswordRule.special.isMetBy('abc!'), isTrue);
  });

  test('requires every rule', () {
    expect(PasswordRule.allMetBy('Mijoo-2026'), isTrue);
    expect(PasswordRule.allMetBy('mijoo-2026'), isFalse);
  });
}
