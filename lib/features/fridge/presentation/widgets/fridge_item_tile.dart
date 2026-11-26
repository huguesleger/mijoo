import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/presentation/fridge_navigation.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';

class FridgeItemTile extends StatelessWidget {
  const FridgeItemTile({required this.item, super.key});

  final FridgeItem item;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => openFridgeItemSheet(context, some(item)),
    borderRadius: MjRadius.field,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: MjSpacing.fieldGap),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.name, style: MjTextStyles.sectionTitle),
                ...item.bestBefore.match(
                  () => const <Widget>[],
                  (DateTime date) => <Widget>[
                    const SizedBox(height: MjSpacing.extraSmall),
                    Text(
                      t.fridge.bestBefore(date: MaterialLocalizations.of(context).formatMediumDate(date)),
                      style: MjTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: MjSpacing.medium),
          Text(fridgeQuantityLabel(item), style: MjTextStyles.choice),
        ],
      ),
    ),
  );
}
