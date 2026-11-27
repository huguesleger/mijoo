import 'package:intl/intl.dart';

String euros(double cents) => NumberFormat.currency(
  locale: 'fr',
  symbol: '€',
  decimalDigits: cents.round() % 100 == 0 ? 0 : 2,
).format(cents / 100);

String preciseEuros(double cents) =>
    NumberFormat.currency(locale: 'fr', symbol: '€', decimalDigits: 2).format(cents / 100);

String shortDate(DateTime date) => DateFormat('d MMM', 'fr').format(date);

String dayDate(DateTime date) => DateFormat('EEEE d MMM', 'fr').format(date);
