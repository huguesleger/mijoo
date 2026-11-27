import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';

class MealDeductionRow extends StatelessWidget {
  const MealDeductionRow({
    required this.deduction,
    required this.selected,
    required this.onToggle,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final MealDeduction deduction;
  final bool selected;
  final VoidCallback onToggle;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(MjSpacing.fieldGap, 10, MjSpacing.small, 10),
    decoration: BoxDecoration(
      color: MjColors.onInk,
      borderRadius: MjRadius.item,
      border: Border.all(color: MjColors.cardBorder),
    ),
    child: Row(
      children: <Widget>[
        Semantics(
          button: true,
          checked: selected,
          label: selected ? t.meals.keep(name: deduction.item.name) : t.meals.remove(name: deduction.item.name),
          excludeSemantics: true,
          child: InkWell(
            onTap: onToggle,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: MjCheckCircle(checked: selected),
            ),
          ),
        ),
        const SizedBox(width: MjSpacing.small),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(deduction.item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.itemTitle),
              Text(
                t.meals.left(quantity: fridgeQuantityLabel(deduction.item.quantity, deduction.item.unit)),
                style: MjTextStyles.detail.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        MjStepButton(
          icon: LucideIcons.minus,
          tooltip: t.meals.less(name: deduction.item.name),
          onPressed: selected ? onDecrease : null,
        ),
        SizedBox(
          width: 64,
          child: Text(
            fridgeQuantityLabel(deduction.quantity, deduction.item.unit),
            textAlign: TextAlign.center,
            style: MjTextStyles.itemTitle.copyWith(
              fontSize: 13,
              color: selected ? MjColors.ink : MjColors.placeholder,
            ),
          ),
        ),
        MjStepButton(
          icon: LucideIcons.plus,
          tooltip: t.meals.more(name: deduction.item.name),
          onPressed: selected ? onIncrease : null,
        ),
      ],
    ),
  );
}
