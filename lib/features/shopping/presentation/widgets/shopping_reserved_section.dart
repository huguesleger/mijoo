import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_reservation.dart';

class ShoppingReservedSection extends StatelessWidget {
  const ShoppingReservedSection({required this.reservations, super.key});

  final List<ShoppingReservation> reservations;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: 7,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: MjSpacing.small),
        child: Row(
          spacing: MjSpacing.small,
          children: <Widget>[
            const MjIconTile(icon: LucideIcons.lock, tone: MjTone.lavender, size: 30),
            Expanded(
              child: MjSectionTitle(
                title: t.shopping.reserved,
                trailing: some(
                  Text(t.shopping.reservedCount(count: reservations.length), style: MjTextStyles.detail),
                ),
              ),
            ),
          ],
        ),
      ),
      for (final ShoppingReservation reservation in reservations)
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: MjColors.field, borderRadius: MjRadius.item),
          child: Row(
            children: <Widget>[
              MjIconTile(
                icon: fridgeCategoryIcon(reservation.item.category),
                tone: fridgeCategoryTone(reservation.item.category),
                size: 36,
              ),
              const SizedBox(width: MjSpacing.fieldGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(reservation.item.name, style: MjTextStyles.itemTitle),
                    Text(
                      t.shopping.reservedFor(
                        meals: reservation.meals.join(' · '),
                        quantity: fridgeQuantityLabel(reservation.quantity, reservation.item.unit),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: MjTextStyles.detail.copyWith(fontSize: 11.5),
                    ),
                  ],
                ),
              ),
              MjTag(label: t.shopping.reservedTag, tone: MjTone.lavender),
            ],
          ),
        ),
    ],
  );
}
