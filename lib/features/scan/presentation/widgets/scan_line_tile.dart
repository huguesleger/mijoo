import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/presentation/fridge_navigation.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_kind.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_result.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/presentation/bloc/scan_cubit.dart';

class ScanLineTile extends StatelessWidget {
  const ScanLineTile({required this.index, required this.line, super.key});

  final int index;
  final ScanLine line;

  Future<void> _edit(BuildContext context) {
    final ScanCubit cubit = context.read<ScanCubit>();
    return showFridgeItemSheet(context, initial: some(line.input), kind: FridgeSheetKind.edit).then(
      (FridgeSheetResult? result) => switch (result) {
        FridgeSheetSaved(:final FridgeItemInput input) => cubit.edit(index, input),
        FridgeSheetDeleted() => cubit.remove(index),
        null => null,
      },
    );
  }

  @override
  Widget build(BuildContext context) => MjListCard(
    onTap: () => context.read<ScanCubit>().toggle(index),
    child: Row(
      children: <Widget>[
        Semantics(
          checked: line.selected,
          label: line.input.name,
          excludeSemantics: true,
          child: MjCheckCircle(checked: line.selected),
        ),
        const SizedBox(width: MjSpacing.fieldGap),
        MjIconTile(
          icon: fridgeCategoryIcon(line.input.category),
          tone: fridgeCategoryTone(line.input.category),
          size: 42,
        ),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: MjSpacing.extraSmall,
            children: <Widget>[
              Text(line.input.name, style: MjTextStyles.itemTitle),
              Text(fridgeQuantityLabel(line.input.quantity, line.input.unit), style: MjTextStyles.detail),
              ...switch (line.confidence) {
                ScanConfidence.sure => const <Widget>[],
                ScanConfidence.uncertain => <Widget>[
                  MjTag(label: t.scan.uncertain, tone: MjTone.apricot, icon: some(LucideIcons.eye)),
                ],
              },
              ...line.existing.match(
                () => const <Widget>[],
                (_) => <Widget>[
                  MjTag(label: t.scan.alreadyInFridge, tone: MjTone.lavender, icon: some(LucideIcons.plus)),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: t.scan.edit,
          onPressed: () => _edit(context),
          icon: const Icon(LucideIcons.pencil, size: 18, color: MjColors.placeholder),
        ),
      ],
    ),
  );
}
