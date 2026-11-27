import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_freshness_tag.dart';

class HomeFinishFirstCard extends StatelessWidget {
  const HomeFinishFirstCard({required this.item, required this.today, super.key});

  final FridgeItem item;
  final DateTime today;

  @override
  Widget build(BuildContext context) => Container(
    width: 124,
    padding: const EdgeInsets.all(MjSpacing.fieldGap),
    decoration: BoxDecoration(
      color: MjColors.onInk,
      borderRadius: MjRadius.item,
      border: Border.all(color: MjColors.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MjIconTile(icon: fridgeCategoryIcon(item.category), tone: fridgeCategoryTone(item.category)),
        const SizedBox(height: 10),
        Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.itemTitle),
        const SizedBox(height: 6),
        FridgeFreshnessTag(item: item, today: today),
      ],
    ),
  );
}
