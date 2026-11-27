import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_labels.dart';

class ShoppingStoreRow extends StatelessWidget {
  const ShoppingStoreRow({
    required this.line,
    required this.quantity,
    required this.selected,
    required this.onToggle,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final ShoppingLine line;
  final double quantity;
  final bool selected;
  final VoidCallback onToggle;
  final VoidCallback? onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(6, MjSpacing.small, MjSpacing.small, MjSpacing.small),
    decoration: BoxDecoration(
      color: MjColors.onInk,
      borderRadius: MjRadius.item,
      border: Border.all(color: MjColors.cardBorder),
    ),
    child: Row(
      children: <Widget>[
        Semantics(
          button: true,
          checked: selected,
          label: selected ? t.shopping.skipFridge(name: line.name) : t.shopping.keepInFridge(name: line.name),
          excludeSemantics: true,
          child: InkWell(
            onTap: onToggle,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: MjCheckCircle(checked: selected),
            ),
          ),
        ),
        const SizedBox(width: MjSpacing.small),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(line.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.itemTitle),
              Text(
                selected ? t.fridge.categories[line.category.name] ?? line.category.name : t.shopping.outsideFridge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MjTextStyles.detail.copyWith(fontSize: 11.5),
              ),
            ],
          ),
        ),
        if (selected) ...<Widget>[
          MjStepButton(icon: LucideIcons.minus, tooltip: t.shopping.less, onPressed: onDecrease),
          SizedBox(
            width: 70,
            child: Text(
              shoppingQuantityLabel(line, quantity),
              textAlign: TextAlign.center,
              style: MjTextStyles.cardTitle.copyWith(fontSize: 13),
            ),
          ),
          MjStepButton(icon: LucideIcons.plus, tooltip: t.shopping.more, onPressed: onIncrease),
        ] else
          MjIconTile(icon: fridgeCategoryIcon(line.category), tone: MjTone.neutral, size: 34),
      ],
    ),
  );
}
