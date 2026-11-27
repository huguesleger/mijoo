import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show some;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_labels.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_sheet_result.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_step.dart';

class ShoppingLineSheet extends StatefulWidget {
  const ShoppingLineSheet({required this.line, super.key});

  final ShoppingLine line;

  @override
  State<ShoppingLineSheet> createState() => _ShoppingLineSheetState();
}

class _ShoppingLineSheetState extends State<ShoppingLineSheet> {
  late double _quantity = widget.line.purchase;
  late FridgeCategory _category = widget.line.category;

  @override
  Widget build(BuildContext context) {
    final ShoppingLine line = widget.line;
    final double step = shoppingStep(line);
    return MjBottomSheet(
      title: line.name,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (line.meals.isNotEmpty) ...<Widget>[
              Text(line.meals.join(' · '), style: MjTextStyles.detail),
              const SizedBox(height: MjSpacing.medium),
            ],
            Text(t.shopping.quantityTitle, style: MjTextStyles.fieldLabel),
            const SizedBox(height: MjSpacing.small),
            Row(
              spacing: 10,
              children: <Widget>[
                MjStepButton(
                  icon: LucideIcons.minus,
                  tooltip: t.shopping.less,
                  onPressed: _quantity > step ? () => setState(() => _quantity = _quantity - step) : null,
                ),
                Expanded(
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: MjColors.field, borderRadius: MjRadius.item),
                    child: Text(
                      shoppingQuantityLabel(line, _quantity),
                      style: MjTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                MjStepButton(
                  icon: LucideIcons.plus,
                  tooltip: t.shopping.more,
                  filled: true,
                  onPressed: () => setState(() => _quantity = min(_quantity + step, maxFridgeQuantity)),
                ),
              ],
            ),
            ...line.needed.match(
              () => const <Widget>[],
              (double needed) => <Widget>[
                const SizedBox(height: MjSpacing.fieldGap),
                MjMessageView(
                  icon: some(LucideIcons.package),
                  message: line.pack.match(
                    () => t.shopping.neededExplained(quantity: readableQuantity(needed, line.unit)),
                    (pack) =>
                        t.shopping.packExplained(quantity: readableQuantity(needed, line.unit), pack: packLabel(pack)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MjSpacing.medium),
            Text(t.shopping.aisle, style: MjTextStyles.fieldLabel),
            const SizedBox(height: MjSpacing.small),
            Wrap(
              spacing: MjSpacing.small,
              runSpacing: MjSpacing.small,
              children: <Widget>[
                for (final FridgeCategory category in FridgeCategory.values)
                  MjChoiceChip(
                    label: t.fridge.shortCategories[category.name] ?? category.name,
                    icon: some(fridgeCategoryIcon(category)),
                    selected: category == _category,
                    onTap: () => setState(() => _category = category),
                  ),
              ],
            ),
            const SizedBox(height: MjSpacing.large),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(ShoppingLineSaved(_quantity, _category)),
              child: Text(t.shopping.save),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: MjColors.error),
              onPressed: () => Navigator.of(context).pop(const ShoppingLineRemoved()),
              child: Text(t.shopping.remove),
            ),
          ],
        ),
      ),
    );
  }
}
