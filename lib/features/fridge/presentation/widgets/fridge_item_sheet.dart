import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intl/intl.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_item_form.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_kind.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_result.dart';
import 'package:mijoo/features/scan/presentation/bloc/best_before_cubit.dart';

class FridgeItemSheet extends StatefulWidget {
  const FridgeItemSheet({required this.initial, required this.kind, super.key});

  final Option<FridgeItemInput> initial;
  final FridgeSheetKind kind;

  @override
  State<FridgeItemSheet> createState() => _FridgeItemSheetState();
}

class _FridgeItemSheetState extends State<FridgeItemSheet> {
  late String _name = widget.initial.match(() => '', (FridgeItemInput item) => item.name);
  late String _quantity = widget.initial.match(
    () => '1',
    (FridgeItemInput item) => NumberFormat.decimalPattern('fr').format(item.quantity),
  );
  late FridgeUnit _unit = widget.initial.match(() => FridgeUnit.piece, (FridgeItemInput item) => item.unit);
  late FridgeCategory _category = widget.initial.match(
    () => FridgeCategory.fruitsVegetables,
    (FridgeItemInput item) => item.category,
  );
  late Option<DateTime> _bestBefore = widget.initial.flatMap((FridgeItemInput item) => item.bestBefore);

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
    title: switch (widget.kind) {
      FridgeSheetKind.add => t.fridge.addTitle,
      FridgeSheetKind.edit => t.fridge.editTitle,
    },
    child: BlocListener<BestBeforeCubit, BestBeforeState>(
      listener: (_, BestBeforeState state) => switch (state) {
        BestBeforeRead(:final DateTime date) => setState(() => _bestBefore = some(date)),
        BestBeforeIdle() || BestBeforeReading() || BestBeforeNotFound() || BestBeforeFailed() => null,
      },
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
              child: Text(switch (widget.kind) {
                FridgeSheetKind.add => t.fridge.create,
                FridgeSheetKind.edit => t.fridge.save,
              }),
            ),
            ...switch (widget.kind) {
              FridgeSheetKind.add => const <Widget>[],
              FridgeSheetKind.edit => <Widget>[
                const SizedBox(height: MjSpacing.small),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: MjColors.error),
                  onPressed: () => Navigator.of(context).pop<FridgeSheetResult>(const FridgeSheetDeleted()),
                  child: Text(t.fridge.delete),
                ),
              ],
            },
          ],
        ),
      ),
    ),
  );
}
