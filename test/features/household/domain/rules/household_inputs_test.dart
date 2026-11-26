import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/rules/household_inputs.dart';

void main() {
  test('reads a weekly budget in euros', () {
    expect(parseWeeklyBudgetCents(''), some(none<int>()));
    expect(parseWeeklyBudgetCents('120'), some(some(12000)));
    expect(parseWeeklyBudgetCents('85,5'), some(some(8550)));
    expect(parseWeeklyBudgetCents(' 1 200,25 '), some(some(120025)));
    expect(parseWeeklyBudgetCents('abc'), none<Option<int>>());
    expect(parseWeeklyBudgetCents('12,345'), none<Option<int>>());
  });

  test('accepts an empty or five-digit postal code', () {
    expect(isValidPostalCode(''), isTrue);
    expect(isValidPostalCode('69001'), isTrue);
    expect(isValidPostalCode('6900'), isFalse);
    expect(isValidPostalCode('69 001'), isFalse);
  });
}
