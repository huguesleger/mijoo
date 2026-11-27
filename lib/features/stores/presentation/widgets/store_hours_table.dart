import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/week_hours.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoreHoursTable extends StatelessWidget {
  const StoreHoursTable({required this.hours, required this.today, super.key});

  final WeekHours hours;
  final int today;

  @override
  Widget build(BuildContext context) => Column(
    spacing: 6,
    children: <Widget>[
      for (int weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                weekday == today ? t.stores.today(day: t.stores.dayNames[weekday - 1]) : t.stores.dayNames[weekday - 1],
                style: MjTextStyles.body.copyWith(color: weekday == today ? MjColors.primary : MjColors.ink),
              ),
            ),
            Text(
              hours.on(weekday).isEmpty
                  ? t.stores.closedDay
                  : hours
                        .on(weekday)
                        .map(
                          (TimeRange range) => t.stores.range(start: timeLabel(range.start), end: timeLabel(range.end)),
                        )
                        .join(', '),
              style: MjTextStyles.body.copyWith(color: weekday == today ? MjColors.primary : MjColors.ink),
            ),
          ],
        ),
    ],
  );
}
