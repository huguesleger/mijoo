import 'package:fpdart/fpdart.dart';

final class MealStep {
  const MealStep({required this.text, required this.minutes});

  final String text;
  final Option<int> minutes;
}
