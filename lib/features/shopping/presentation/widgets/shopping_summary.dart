import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ShoppingSummary extends StatelessWidget {
  const ShoppingSummary({required this.toBuy, required this.inBasket, required this.plannedMeals, super.key});

  final int toBuy;
  final int inBasket;
  final int plannedMeals;

  @override
  Widget build(BuildContext context) => Row(
    spacing: MjSpacing.small,
    children: <Widget>[
      Expanded(
        child: MjStatCard(value: '$toBuy', label: t.shopping.toBuy, tone: MjTone.neutral),
      ),
      Expanded(
        child: MjStatCard(value: '$inBasket', label: t.shopping.inBasket, tone: MjTone.green),
      ),
      Expanded(
        child: MjStatCard(value: '$plannedMeals', label: t.shopping.plannedMeals, tone: MjTone.lavender),
      ),
    ],
  );
}
