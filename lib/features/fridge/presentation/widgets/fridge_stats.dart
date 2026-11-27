import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';

class FridgeStats extends StatelessWidget {
  const FridgeStats({required this.items, required this.today, super.key});

  final List<FridgeItem> items;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final FridgeFreshnessSummary summary = fridgeFreshnessSummary(items, today);
    return Row(
      spacing: MjSpacing.small,
      children: <Widget>[
        Expanded(
          child: MjStatCard(
            value: '${summary.total}',
            label: summary.total <= 1 ? t.fridge.stats.totalSingle : t.fridge.stats.totalSeveral,
            tone: MjTone.neutral,
          ),
        ),
        Expanded(
          child: MjStatCard(value: '${summary.toFinish}', label: t.fridge.stats.toFinish, tone: MjTone.apricot),
        ),
        Expanded(
          child: MjStatCard(
            value: '${summary.expired}',
            label: summary.expired <= 1 ? t.fridge.stats.expiredSingle : t.fridge.stats.expiredSeveral,
            tone: MjTone.peony,
          ),
        ),
      ],
    );
  }
}
