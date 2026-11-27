import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show some;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_sheet_result.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_step.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_store_row.dart';

class ShoppingStoreSheet extends StatefulWidget {
  const ShoppingStoreSheet({required this.checked, super.key});

  final List<ShoppingLine> checked;

  @override
  State<ShoppingStoreSheet> createState() => _ShoppingStoreSheetState();
}

class _ShoppingStoreSheetState extends State<ShoppingStoreSheet> {
  late final Map<ShoppingEntryId, double> _quantities = <ShoppingEntryId, double>{
    for (final ShoppingLine line in widget.checked) line.id: line.purchase,
  };
  late Set<ShoppingEntryId> _selected = <ShoppingEntryId>{
    for (final ShoppingLine line in widget.checked)
      if (!line.manual) line.id,
  };

  @override
  Widget build(BuildContext context) {
    final int count = _selected.length;
    return MjBottomSheet(
      title: t.shopping.storeTitle,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: MjSpacing.small,
          children: <Widget>[
            Text(
              widget.checked.length == 1
                  ? t.shopping.storeMessageSingle
                  : t.shopping.storeMessageSeveral(count: widget.checked.length),
              style: MjTextStyles.detail,
            ),
            for (final ShoppingLine line in widget.checked)
              ShoppingStoreRow(
                line: line,
                quantity: _quantities[line.id]!,
                selected: _selected.contains(line.id),
                onToggle: () => setState(
                  () => _selected = _selected.contains(line.id)
                      ? _selected.difference(<ShoppingEntryId>{line.id})
                      : <ShoppingEntryId>{..._selected, line.id},
                ),
                onDecrease: _quantities[line.id]! > shoppingStep(line)
                    ? () => setState(() => _quantities[line.id] = _quantities[line.id]! - shoppingStep(line))
                    : null,
                onIncrease: () => setState(
                  () => _quantities[line.id] = min(_quantities[line.id]! + shoppingStep(line), maxFridgeQuantity),
                ),
              ),
            MjMessageView(icon: some(LucideIcons.refrigerator), message: t.shopping.storeNote),
            const SizedBox(height: MjSpacing.extraSmall),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(
                ShoppingStoreConfirmed(<({ShoppingLine line, double quantity})>[
                  for (final ShoppingLine line in widget.checked)
                    if (_selected.contains(line.id)) (line: line, quantity: _quantities[line.id]!),
                ]),
              ),
              icon: const Icon(LucideIcons.refrigerator),
              label: Text(switch (count) {
                0 => t.shopping.storeZero,
                1 => t.shopping.storeSingle,
                _ => t.shopping.storeSeveral(count: count),
              }),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(t.shopping.later)),
          ],
        ),
      ),
    );
  }
}
