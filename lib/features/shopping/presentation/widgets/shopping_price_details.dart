import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';
import 'package:mijoo/features/shopping/domain/entities/price_reliability.dart';
import 'package:mijoo/features/shopping/domain/entities/price_source.dart';
import 'package:mijoo/features/shopping/domain/entities/reference_price.dart';
import 'package:mijoo/features/shopping/domain/rules/prices.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';

class ShoppingPriceDetails extends StatelessWidget {
  const ShoppingPriceDetails({required this.cost, required this.today, super.key});

  final LineCost cost;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final ReferencePrice price = cost.price;
    final PriceReliability reliability = priceReliability(price, today);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: MjSpacing.extraSmall,
      children: <Widget>[
        Text(
          t.shopping.approx(amount: preciseEuros(cost.cents)),
          textAlign: TextAlign.center,
          style: MjTextStyles.display,
        ),
        Text(
          switch (price.basis) {
            PriceBasis.kilogram => t.shopping.perKilogram(price: preciseEuros(price.cents)),
            PriceBasis.liter => t.shopping.perLiter(price: preciseEuros(price.cents)),
            PriceBasis.piece => t.shopping.perPiece(price: preciseEuros(price.cents)),
          },
          textAlign: TextAlign.center,
          style: MjTextStyles.detail,
        ),
        if (price.source != PriceSource.household)
          Text(
            switch (price.basis) {
              PriceBasis.kilogram => t.shopping.rangeKilogram(
                low: preciseEuros(price.lowCents),
                high: preciseEuros(price.highCents),
              ),
              PriceBasis.liter => t.shopping.rangeLiter(
                low: preciseEuros(price.lowCents),
                high: preciseEuros(price.highCents),
              ),
              PriceBasis.piece => t.shopping.rangePiece(
                low: preciseEuros(price.lowCents),
                high: preciseEuros(price.highCents),
              ),
            },
            textAlign: TextAlign.center,
            style: MjTextStyles.detail.copyWith(fontSize: 12),
          ),
        const SizedBox(height: MjSpacing.small),
        Container(
          padding: const EdgeInsets.all(MjSpacing.fieldGap),
          decoration: const BoxDecoration(color: MjColors.field, borderRadius: MjRadius.item),
          child: Row(
            children: <Widget>[
              Icon(LucideIcons.database, size: 20, color: MjTone.lavender.foreground),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      <String>[
                        t.shopping.sources[price.source.name] ?? price.source.name,
                        if (price.source == PriceSource.openPrices)
                          price.observations == 1
                              ? t.shopping.observationsSingle
                              : t.shopping.observationsSeveral(count: price.observations),
                      ].join(' · '),
                      style: MjTextStyles.detail.copyWith(color: MjColors.ink),
                    ),
                    ...price.lastSeen.match(
                      () => const <Widget>[],
                      (DateTime date) => <Widget>[
                        Text(
                          t.shopping.lastSeen(date: shortDate(date)),
                          style: MjTextStyles.detail.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MjSignalBars(
                level: reliability.index + 1,
                maximum: PriceReliability.values.length,
                label: t.shopping.reliabilities[reliability.name] ?? reliability.name,
              ),
            ],
          ),
        ),
        Text(
          t.shopping.reliabilities[reliability.name] ?? '',
          textAlign: TextAlign.end,
          style: MjTextStyles.detail.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
