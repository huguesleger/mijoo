import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity_step.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_cooked_result.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_deduction_row.dart';

class MealCookedSheet extends StatefulWidget {
  const MealCookedSheet({required this.proposed, super.key});

  final List<MealDeduction> proposed;

  @override
  State<MealCookedSheet> createState() => _MealCookedSheetState();
}

class _MealCookedSheetState extends State<MealCookedSheet> {
  late List<MealDeduction> _deductions = widget.proposed;
  late Set<FridgeItemId> _selected = <FridgeItemId>{
    for (final MealDeduction deduction in widget.proposed) deduction.item.id,
  };

  void _change(int index, double quantity) => setState(
    () => _deductions = <MealDeduction>[
      for (final (int position, MealDeduction deduction) in _deductions.indexed)
        position == index ? MealDeduction(item: deduction.item, quantity: quantity) : deduction,
    ],
  );

  void _toggle(FridgeItemId item) => setState(
    () => _selected = _selected.contains(item)
        ? _selected.difference(<FridgeItemId>{item})
        : <FridgeItemId>{..._selected, item},
  );

  @override
  Widget build(BuildContext context) {
    final List<MealDeduction> chosen = _deductions
        .where((MealDeduction deduction) => _selected.contains(deduction.item.id))
        .toList();
    return MjBottomSheet(
      title: t.meals.cookedTitle,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: MjSpacing.small,
          children: <Widget>[
            Text(_deductions.isEmpty ? t.meals.cookedNothing : t.meals.cookedMessage, style: MjTextStyles.detail),
            const SizedBox(height: MjSpacing.extraSmall),
            for (final (int index, MealDeduction deduction) in _deductions.indexed)
              MealDeductionRow(
                deduction: deduction,
                selected: _selected.contains(deduction.item.id),
                onToggle: () => _toggle(deduction.item.id),
                onDecrease: deduction.quantity > fridgeQuantityStep(deduction.item.unit)
                    ? () => _change(index, deduction.quantity - fridgeQuantityStep(deduction.item.unit))
                    : null,
                onIncrease: deduction.quantity < deduction.item.quantity
                    ? () => _change(
                        index,
                        min(deduction.item.quantity, deduction.quantity + fridgeQuantityStep(deduction.item.unit)),
                      )
                    : null,
              ),
            Container(
              margin: const EdgeInsets.only(top: MjSpacing.extraSmall, bottom: MjSpacing.small),
              padding: const EdgeInsets.all(MjSpacing.fieldGap),
              decoration: const BoxDecoration(color: MjColors.field, borderRadius: MjRadius.item),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(LucideIcons.history, size: 18, color: MjColors.primary),
                  const SizedBox(width: 10),
                  Expanded(child: Text(t.meals.historyNote, style: MjTextStyles.detail.copyWith(fontSize: 12))),
                ],
              ),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(MealCookedUpdateFridge(chosen)),
              child: Text(chosen.isEmpty ? t.meals.saveMeal : t.meals.updateFridge),
            ),
            if (_deductions.isNotEmpty)
              TextButton(
                onPressed: () => Navigator.of(context).pop(const MealCookedKeepFridge()),
                child: Text(t.meals.keepFridge),
              ),
          ],
        ),
      ),
    );
  }
}
