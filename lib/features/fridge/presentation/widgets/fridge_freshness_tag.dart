import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';

class FridgeFreshnessTag extends StatelessWidget {
  const FridgeFreshnessTag({required this.item, required this.today, super.key});

  final FridgeItem item;
  final DateTime today;

  @override
  Widget build(BuildContext context) => switch (fridgeFreshness(item, today)) {
    FridgeFreshness.fresh => const SizedBox.shrink(),
    FridgeFreshness.expired => MjTag(label: t.fridge.freshness.expired, tone: MjTone.peony),
    FridgeFreshness.urgent || FridgeFreshness.soon => switch (daysLeft(item, today).getOrElse(() => 0)) {
      0 => MjTag(label: t.fridge.freshness.today, tone: MjTone.peony),
      1 => MjTag(label: t.fridge.freshness.tomorrow, tone: MjTone.peony),
      final int days => MjTag(
        label: t.fridge.freshness.inDays(count: days),
        tone: MjTone.apricot,
      ),
    },
  };
}
