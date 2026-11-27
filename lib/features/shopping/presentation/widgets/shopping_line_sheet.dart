import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option, identity, none, some;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/household/domain/rules/household_inputs.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/price_book.dart';
import 'package:mijoo/features/shopping/domain/entities/reference_price.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_labels.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_price_details.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_sheet_result.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_step.dart';

class ShoppingLineSheet extends StatefulWidget {
  const ShoppingLineSheet({required this.line, required this.book, required this.today, super.key});

  final ShoppingLine line;
  final PriceBook book;
  final DateTime today;

  @override
  State<ShoppingLineSheet> createState() => _ShoppingLineSheetState();
}

class _ShoppingLineSheetState extends State<ShoppingLineSheet> {
  late double _quantity = widget.line.purchase;
  late FridgeCategory _category = widget.line.category;
  String _myPrice = '';

  PriceBasis get _basis => referencePrice(widget.line.name, widget.book).match(
    () => basisFor(widget.line.unit),
    (ReferencePrice price) => price.basis,
  );

  Option<Option<HouseholdPrice>> get _price => parseWeeklyBudgetCents(_myPrice).map(
    (Option<int> cents) => cents.map(
      (int cents) => HouseholdPrice(
        key: ingredientKey(widget.line.name),
        name: widget.line.name,
        cents: cents.toDouble(),
        basis: _basis,
      ),
    ),
  );

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
            Text(t.shopping.priceTitle, style: MjTextStyles.fieldLabel),
            const SizedBox(height: MjSpacing.small),
            ...costOf(line.name, _quantity, line.unit, widget.book).match(
              () => const <Widget>[],
              (LineCost cost) => <Widget>[
                ShoppingPriceDetails(cost: cost, today: widget.today),
                const SizedBox(height: MjSpacing.medium),
              ],
            ),
            MjTextField(
              label: t.shopping.myPrice[_basis.name] ?? '',
              hint: t.shopping.myPriceHint,
              icon: LucideIcons.pencil,
              initialValue: '',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              suffixText: some(t.shopping.priceUnit[_basis.name] ?? '€'),
              error: _price.isNone() ? some(t.shopping.priceInvalid) : none(),
              onChanged: (String price) => setState(() => _myPrice = price),
            ),
            const SizedBox(height: MjSpacing.extraSmall),
            Text(t.shopping.myPriceHelp, style: MjTextStyles.detail.copyWith(fontSize: 11)),
            const SizedBox(height: MjSpacing.large),
            FilledButton(
              onPressed: _price.isNone()
                  ? null
                  : () => Navigator.of(context).pop(ShoppingLineSaved(_quantity, _category, _price.flatMap(identity))),
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
