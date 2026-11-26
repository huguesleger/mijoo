import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_sections.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_item_tile.dart';

class FridgeSectionCard extends StatelessWidget {
  const FridgeSectionCard({required this.section, super.key});

  final FridgeSection section;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: MjSpacing.extraSmall, bottom: MjSpacing.small),
        child: Semantics(
          header: true,
          child: Text(
            t.fridge.categories[section.category.name] ?? section.category.name,
            style: MjTextStyles.fieldLabel,
          ),
        ),
      ),
      MjCard(
        child: Column(
          children: <Widget>[
            for (final (int index, FridgeItem item) in section.items.indexed) ...<Widget>[
              if (index > 0) const Divider(height: 1, color: MjColors.neutralChip),
              FridgeItemTile(item: item),
            ],
          ],
        ),
      ),
    ],
  );
}
