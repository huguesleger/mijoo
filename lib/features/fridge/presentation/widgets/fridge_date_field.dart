import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class FridgeDateField extends StatelessWidget {
  const FridgeDateField({required this.date, required this.onChanged, super.key});

  final Option<DateTime> date;
  final ValueChanged<Option<DateTime>> onChanged;

  Future<void> _pick(BuildContext context) async {
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date.getOrElse(() => today),
      firstDate: today.subtract(const Duration(days: 30)),
      lastDate: today.add(const Duration(days: 3 * 365)),
    );
    if (picked != null) onChanged(some(picked));
  }

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(t.fridge.date, style: MjTextStyles.fieldLabel),
            const SizedBox(height: MjSpacing.extraSmall),
            Text(
              date.match(
                () => t.fridge.dateOptional,
                (DateTime date) => MaterialLocalizations.of(context).formatMediumDate(date),
              ),
              style: MjTextStyles.caption,
            ),
          ],
        ),
      ),
      ...date.match(
        () => const <Widget>[],
        (_) => <Widget>[
          IconButton(tooltip: t.fridge.dateRemove, onPressed: () => onChanged(none()), icon: const Icon(LucideIcons.x)),
        ],
      ),
      MjRoundIconButton(
        icon: LucideIcons.calendarPlus,
        tooltip: t.fridge.dateAdd,
        highlighted: true,
        onPressed: () => _pick(context),
      ),
    ],
  );
}
