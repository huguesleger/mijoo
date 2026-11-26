import 'package:fpdart/fpdart.dart';

const double maxFridgeQuantity = 100000;

Option<double> parseFridgeQuantity(String input) => Option<double>.fromNullable(
  double.tryParse(input.trim().replaceAll(' ', '').replaceAll(',', '.')),
).filter((double quantity) => quantity > 0 && quantity <= maxFridgeQuantity);
