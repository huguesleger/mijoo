import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_choice_wrap.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_date_field.dart';

class FridgeItemForm extends StatelessWidget {
  const FridgeItemForm({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.bestBefore,
    required this.onName,
    required this.onQuantity,
    required this.onUnit,
    required this.onCategory,
    required this.onBestBefore,
    super.key,
  });

  final String name;
  final String quantity;
  final FridgeUnit unit;
  final FridgeCategory category;
  final Option<DateTime> bestBefore;
  final ValueChanged<String> onName;
  final ValueChanged<String> onQuantity;
  final ValueChanged<FridgeUnit> onUnit;
  final ValueChanged<FridgeCategory> onCategory;
  final ValueChanged<Option<DateTime>> onBestBefore;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      MjTextField(
        label: t.fridge.name,
        hint: t.fridge.nameHint,
        icon: LucideIcons.carrot,
        initialValue: name,
        onChanged: onName,
      ),
      const SizedBox(height: MjSpacing.fieldGap),
      MjTextField(
        label: t.fridge.quantity,
        hint: t.fridge.quantityHint,
        icon: LucideIcons.scale,
        initialValue: quantity,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        error: quantity.trim().isEmpty || parseFridgeQuantity(quantity).isSome()
            ? none()
            : some(t.fridge.quantityInvalid),
        onChanged: onQuantity,
      ),
      const SizedBox(height: MjSpacing.large),
      FridgeChoiceWrap<FridgeUnit>(
        title: t.fridge.unit,
        values: FridgeUnit.values,
        labels: t.fridge.units,
        selected: unit,
        onSelected: onUnit,
      ),
      const SizedBox(height: MjSpacing.large),
      FridgeChoiceWrap<FridgeCategory>(
        title: t.fridge.category,
        values: FridgeCategory.values,
        labels: t.fridge.categories,
        selected: category,
        onSelected: onCategory,
      ),
      const SizedBox(height: MjSpacing.large),
      FridgeDateField(date: bestBefore, onChanged: onBestBefore),
    ],
  );
}
