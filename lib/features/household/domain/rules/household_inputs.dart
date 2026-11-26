import 'package:fpdart/fpdart.dart';

Option<Option<int>> parseWeeklyBudgetCents(String input) {
  final text = input.trim().replaceAll(' ', '').replaceAll(',', '.');
  if (text.isEmpty) return some(none());
  final match = RegExp(r'^(\d{1,5})(?:\.(\d{1,2}))?$').firstMatch(text);
  return Option.fromNullable(match).map(
    (match) => some(
      int.parse(match.group(1)!) * 100 + int.parse((match.group(2) ?? '0').padRight(2, '0')),
    ),
  );
}

bool isValidPostalCode(String input) {
  final text = input.trim();
  return text.isEmpty || RegExp(r'^\d{5}$').hasMatch(text);
}
