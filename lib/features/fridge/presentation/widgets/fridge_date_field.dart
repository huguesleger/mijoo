import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_date_read_button.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_date_read_message.dart';

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
  Widget build(BuildContext context) => MjLabeledField(
    label: t.fridge.date,
    field: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: Material(
                color: MjColors.field,
                borderRadius: MjRadius.input,
                child: InkWell(
                  borderRadius: MjRadius.input,
                  onTap: () => _pick(context),
                  child: SizedBox(
                    height: 52,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: MjSpacing.medium),
                        const Icon(LucideIcons.calendar, size: 20, color: MjColors.lavenderStrong),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            date.match(
                              () => t.fridge.dateOptional,
                              (DateTime date) => MaterialLocalizations.of(context).formatMediumDate(date),
                            ),
                            style: date.isSome()
                                ? MjTextStyles.choice
                                : MjTextStyles.choice.copyWith(color: MjColors.placeholder),
                          ),
                        ),
                        ...date.match(
                          () => const <Widget>[],
                          (_) => <Widget>[
                            IconButton(
                              tooltip: t.fridge.dateRemove,
                              onPressed: () => onChanged(none()),
                              icon: const Icon(LucideIcons.x, size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const FridgeDateReadButton(),
          ],
        ),
        const FridgeDateReadMessage(),
      ],
    ),
  );
}
