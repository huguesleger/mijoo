import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/domain/entities/opening_status.dart';
import 'package:mijoo/features/stores/domain/entities/week_hours.dart';

const int minutesPerDay = 24 * 60;
const List<String> _dayCodes = <String>['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
final RegExp _rulePattern = RegExp(
  r'^((?:Mo|Tu|We|Th|Fr|Sa|Su|PH|SH)(?:-(?:Mo|Tu|We|Th|Fr|Sa|Su))?(?:,\s*(?:Mo|Tu|We|Th|Fr|Sa|Su|PH|SH)(?:-(?:Mo|Tu|We|Th|Fr|Sa|Su))?)*)?\s*(.*)$',
);
final RegExp _rangePattern = RegExp(r'^(\d{1,2}):(\d{2})\s*-\s*(\d{1,2}):(\d{2})\+?$');

Option<WeekHours> parseOpeningHours(String raw) => raw.trim() == '24/7'
    ? some(WeekHours(List<List<TimeRange>>.generate(7, (_) => const <TimeRange>[TimeRange(0, minutesPerDay)])))
    : raw
          .split(';')
          .map((String rule) => rule.trim())
          .where((String rule) => rule.isNotEmpty)
          .map(_parseRule)
          .fold<Option<List<Option<List<TimeRange>>>>>(
            some(List<Option<List<TimeRange>>>.filled(7, none())),
            (Option<List<Option<List<TimeRange>>>> week, Option<_Rule> rule) => week.flatMap(
              (List<Option<List<TimeRange>>> days) => rule.map(
                (_Rule rule) => <Option<List<TimeRange>>>[
                  for (int index = 0; index < 7; index++) rule.days.contains(index) ? some(rule.ranges) : days[index],
                ],
              ),
            ),
          )
          .filter((List<Option<List<TimeRange>>> days) => days.any((Option<List<TimeRange>> day) => day.isSome()))
          .map(
            (List<Option<List<TimeRange>>> days) => WeekHours(<List<TimeRange>>[
              for (final Option<List<TimeRange>> day in days) day.getOrElse(() => const <TimeRange>[]),
            ]),
          );

typedef _Rule = ({Set<int> days, List<TimeRange> ranges});

Option<_Rule> _parseRule(String rule) => Option<RegExpMatch>.fromNullable(_rulePattern.firstMatch(rule)).flatMap(
  (RegExpMatch match) => _parseRanges(match.group(2)!.trim()).map(
    (List<TimeRange> ranges) => (days: _parseDays(match.group(1)), ranges: ranges),
  ),
);

Set<int> _parseDays(String? selector) => selector == null
    ? <int>{0, 1, 2, 3, 4, 5, 6}
    : <int>{
        for (final String part in selector.split(',').map((String part) => part.trim()))
          ...switch (part.split('-')) {
            [final String first, final String last] => _span(_dayCodes.indexOf(first), _dayCodes.indexOf(last)),
            [final String day] when _dayCodes.contains(day) => <int>[_dayCodes.indexOf(day)],
            _ => const <int>[],
          },
      };

List<int> _span(int first, int last) => <int>[
  for (int offset = 0; offset <= (last - first) % 7; offset++) (first + offset) % 7,
];

Option<List<TimeRange>> _parseRanges(String times) => switch (times) {
  'off' || 'closed' => some(const <TimeRange>[]),
  '' => none(),
  _ =>
    times
        .split(',')
        .map((String range) => Option<RegExpMatch>.fromNullable(_rangePattern.firstMatch(range.trim())))
        .fold<Option<List<TimeRange>>>(
          some(const <TimeRange>[]),
          (Option<List<TimeRange>> ranges, Option<RegExpMatch> match) => ranges.flatMap(
            (List<TimeRange> ranges) => match.map((RegExpMatch match) => <TimeRange>[...ranges, _toRange(match)]),
          ),
        ),
};

TimeRange _toRange(RegExpMatch match) {
  final int start = int.parse(match.group(1)!) * 60 + int.parse(match.group(2)!);
  final int end = int.parse(match.group(3)!) * 60 + int.parse(match.group(4)!);
  return TimeRange(start, end <= start ? end + minutesPerDay : end);
}

OpeningStatus openingStatus(WeekHours hours, DateTime now) {
  final int minute = now.hour * 60 + now.minute;
  final int yesterday = now.weekday == DateTime.monday ? DateTime.sunday : now.weekday - 1;
  final Option<int> closesToday = Option<TimeRange>.fromNullable(
    hours.on(now.weekday).where((TimeRange range) => range.start <= minute && minute < range.end).firstOrNull,
  ).map((TimeRange range) => range.end);
  final Option<int> closesFromYesterday = Option<TimeRange>.fromNullable(
    hours.on(yesterday).where((TimeRange range) => minute + minutesPerDay < range.end).firstOrNull,
  ).map((TimeRange range) => range.end - minutesPerDay);
  return closesToday
      .alt(() => closesFromYesterday)
      .match(
        () => StoreClosed(_nextOpening(hours, now.weekday, minute)),
        (int end) => StoreOpen(end >= minutesPerDay ? none() : some(end)),
      );
}

Option<StoreMoment> _nextOpening(WeekHours hours, int weekday, int minute) => Option<StoreMoment>.fromNullable(
  <StoreMoment>[
    for (int offset = 0; offset < 8; offset++)
      for (final TimeRange range in hours.on((weekday - 1 + offset) % 7 + 1))
        if (offset > 0 || range.start > minute) (weekday: (weekday - 1 + offset) % 7 + 1, minute: range.start),
  ].firstOrNull,
);
