import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';

void main() {
  test('reads a positive quantity with a comma or a dot', () {
    expect(parseFridgeQuantity('4'), const Some<double>(4));
    expect(parseFridgeQuantity('1,5'), const Some<double>(1.5));
    expect(parseFridgeQuantity(' 0.25 '), const Some<double>(0.25));
  });

  test('refuses an empty, null or too large quantity', () {
    expect(parseFridgeQuantity(''), const None());
    expect(parseFridgeQuantity('0'), const None());
    expect(parseFridgeQuantity('-2'), const None());
    expect(parseFridgeQuantity('abc'), const None());
    expect(parseFridgeQuantity('200000'), const None());
  });
}
