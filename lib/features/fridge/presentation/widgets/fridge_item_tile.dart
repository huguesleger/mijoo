import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/presentation/fridge_navigation.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_freshness_tag.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';

class FridgeItemTile extends StatelessWidget {
  const FridgeItemTile({required this.item, required this.today, super.key});

  final FridgeItem item;
  final DateTime today;

  @override
  Widget build(BuildContext context) => MjListCard(
    onTap: () => openFridgeItemSheet(context, item),
    child: Row(
      children: <Widget>[
        MjIconTile(icon: fridgeCategoryIcon(item.category), tone: fridgeCategoryTone(item.category)),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.itemTitle),
              const SizedBox(height: MjSpacing.extraSmall),
              Text(fridgeQuantityLabel(item.quantity, item.unit), style: MjTextStyles.detail),
            ],
          ),
        ),
        const SizedBox(width: MjSpacing.small),
        FridgeFreshnessTag(item: item, today: today),
      ],
    ),
  );
}
