import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/domain/entities/opening_status.dart';
import 'package:mijoo/features/stores/domain/entities/week_hours.dart';
import 'package:mijoo/features/stores/domain/rules/opening_hours_rules.dart';

void main() {
  WeekHours parse(String raw) => parseOpeningHours(raw).getOrElse(() => fail('not parsed: $raw'));
  List<(int, int)> ranges(WeekHours hours, int weekday) =>
      hours.on(weekday).map((TimeRange range) => (range.start, range.end)).toList();
  final DateTime friday = DateTime(2026, 11, 27, 10, 30);

  test('reads days, ranges and closed days', () {
    final WeekHours hours = parse('Mo-Sa 08:00-12:30,14:00-19:30; Su off');
    expect(ranges(hours, DateTime.monday), [(480, 750), (840, 1170)]);
    expect(ranges(hours, DateTime.saturday), [(480, 750), (840, 1170)]);
    expect(ranges(hours, DateTime.sunday), isEmpty);
  });

  test('lets a later rule override the days it names', () {
    final WeekHours hours = parse('Mo-Su 09:00-20:00; Su 09:00-13:00; PH off');
    expect(ranges(hours, DateTime.saturday), [(540, 1200)]);
    expect(ranges(hours, DateTime.sunday), [(540, 780)]);
  });

  test('reads lists of days, wrapping spans and every day', () {
    expect(ranges(parse('Fr-Mo 10:00-18:00'), DateTime.sunday), [(600, 1080)]);
    expect(ranges(parse('Fr-Mo 10:00-18:00'), DateTime.wednesday), isEmpty);
    expect(ranges(parse('Mo,We 07:00-13:00'), DateTime.wednesday), [(420, 780)]);
    expect(ranges(parse('24/7'), DateTime.thursday), [(0, minutesPerDay)]);
  });

  test('gives up on the rules it cannot read', () {
    expect(parseOpeningHours('Jan-Mar Mo 08:00-12:00'), none<WeekHours>());
    expect(parseOpeningHours('sunrise-sunset'), none<WeekHours>());
    expect(parseOpeningHours('PH off'), none<WeekHours>());
  });

  test('says when an open store closes', () {
    final OpeningStatus status = openingStatus(parse('Mo-Sa 08:00-21:00'), friday);
    expect(status, isA<StoreOpen>().having((StoreOpen it) => it.closesAt, 'closesAt', some(1260)));
  });

  test('says when a closed store opens next', () {
    final WeekHours hours = parse('Mo-Fr 08:00-12:00,14:00-19:00');
    final OpeningStatus atLunch = openingStatus(hours, DateTime(2026, 11, 27, 12, 30));
    expect(atLunch, isA<StoreClosed>().having((it) => it.opensAt, 'opensAt', some((weekday: 5, minute: 840))));
    final OpeningStatus onSunday = openingStatus(hours, DateTime(2026, 11, 29, 10));
    expect(onSunday, isA<StoreClosed>().having((it) => it.opensAt, 'opensAt', some((weekday: 1, minute: 480))));
  });

  test('keeps a store open past midnight', () {
    final OpeningStatus status = openingStatus(parse('Fr 18:00-02:00'), DateTime(2026, 11, 28, 1));
    expect(status, isA<StoreOpen>().having((StoreOpen it) => it.closesAt, 'closesAt', some(120)));
  });
}
