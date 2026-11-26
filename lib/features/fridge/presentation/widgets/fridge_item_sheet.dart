import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intl/intl.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_item_form.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_result.dart';

class FridgeItemSheet extends StatefulWidget {
  const FridgeItemSheet({required this.initial, super.key});

  final Option<FridgeItem> initial;

  @override
  State<FridgeItemSheet> createState() => _FridgeItemSheetState();
}

class _FridgeItemSheetState extends State<FridgeItemSheet> {
  late String _name = widget.initial.match(() => '', (FridgeItem item) => item.name);
  late String _quantity = widget.initial.match(
    () => '1',
    (FridgeItem item) => NumberFormat.decimalPattern('fr').format(item.quantity),
  );
  late FridgeUnit _unit = widget.initial.match(() => FridgeUnit.piece, (FridgeItem item) => item.unit);
  late FridgeCategory _category = widget.initial.match(
    () => FridgeCategory.fruitsVegetables,
    (FridgeItem item) => item.category,
  );
  late Option<DateTime> _bestBefore = widget.initial.flatMap((FridgeItem item) => item.bestBefore);

  Option<FridgeItemInput> get _input => parseFridgeQuantity(_quantity)
      .filter((_) => _name.trim().isNotEmpty)
      .map(
        (double quantity) => FridgeItemInput(
          name: _name.trim(),
          quantity: quantity,
          unit: _unit,
          category: _category,
          bestBefore: _bestBefore,
        ),
      );

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: widget.initial.isSome() ? t.fridge.editTitle : t.fridge.addTitle,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FridgeItemForm(
            name: _name,
            quantity: _quantity,
            unit: _unit,
            category: _category,
            bestBefore: _bestBefore,
            onName: (String name) => setState(() => _name = name),
            onQuantity: (String quantity) => setState(() => _quantity = quantity),
            onUnit: (FridgeUnit unit) => setState(() => _unit = unit),
            onCategory: (FridgeCategory category) => setState(() => _category = category),
            onBestBefore: (Option<DateTime> date) => setState(() => _bestBefore = date),
          ),
          const SizedBox(height: MjSpacing.large),
          FilledButton(
            onPressed: _input.match(
              () => null,
              (FridgeItemInput input) =>
                  () => Navigator.of(context).pop<FridgeSheetResult>(FridgeSheetSaved(input)),
            ),
            child: Text(widget.initial.isSome() ? t.fridge.save : t.fridge.create),
          ),
          ...widget.initial.match(
            () => const <Widget>[],
            (_) => <Widget>[
              const SizedBox(height: MjSpacing.small),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: MjColors.error),
                onPressed: () => Navigator.of(context).pop<FridgeSheetResult>(const FridgeSheetDeleted()),
                child: Text(t.fridge.delete),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
