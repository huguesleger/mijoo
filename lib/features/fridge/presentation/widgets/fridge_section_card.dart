import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_sections.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_item_tile.dart';

class FridgeSectionCard extends StatelessWidget {
  const FridgeSectionCard({required this.section, required this.today, super.key});

  final FridgeSection section;
  final DateTime today;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      MjSectionTitle(
        title: t.fridge.categories[section.category.name] ?? section.category.name,
        trailing: some(Text('${section.items.length}', style: MjTextStyles.detail)),
      ),
      const SizedBox(height: MjSpacing.fieldGap),
      for (final FridgeItem item in section.items)
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: FridgeItemTile(item: item, today: today),
        ),
    ],
  );
}
