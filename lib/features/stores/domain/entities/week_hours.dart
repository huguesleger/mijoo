final class TimeRange {
  const TimeRange(this.start, this.end);

  final int start;
  final int end;
}

final class WeekHours {
  const WeekHours(this.days);

  final List<List<TimeRange>> days;

  List<TimeRange> on(int weekday) => days[weekday - 1];
}
