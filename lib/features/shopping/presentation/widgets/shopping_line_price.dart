import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/price_reliability.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';

class ShoppingLinePrice extends StatelessWidget {
  const ShoppingLinePrice({required this.cost, required this.today, super.key});

  final Option<LineCost> cost;
  final DateTime today;

  @override
  Widget build(BuildContext context) => cost.match(
    () => MjTag(label: t.shopping.addPrice, tone: MjTone.lavender),
    (LineCost cost) {
      final PriceReliability reliability = priceReliability(cost.price, today);
      return Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: <Widget>[
          Text(
            t.shopping.approx(amount: preciseEuros(cost.cents)),
            style: MjTextStyles.detail.copyWith(fontSize: 10.5),
          ),
          MjSignalBars(
            level: reliability.index + 1,
            maximum: PriceReliability.values.length,
            label: t.shopping.reliabilities[reliability.name] ?? reliability.name,
          ),
        ],
      );
    },
  );
}
