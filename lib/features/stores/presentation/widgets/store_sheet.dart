import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/domain/entities/week_hours.dart';
import 'package:mijoo/features/stores/domain/rules/opening_hours_rules.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_hours_table.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_opening_label.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_sheet_choice.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoreSheet extends StatelessWidget {
  const StoreSheet({required this.nearby, required this.now, super.key});

  final NearbyStore nearby;
  final DateTime now;

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: storeName(nearby.store),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              MjIconTile(icon: storeKindIcon(nearby.store.kind), tone: storeKindTone(nearby.store.kind)),
              const SizedBox(width: MjSpacing.fieldGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      t.stores.kindAndDistance(
                        kind: storeKindLabel(nearby.store.kind),
                        distance: distanceLabel(nearby.meters),
                      ),
                      style: MjTextStyles.body,
                    ),
                    StoreOpeningLabel(store: nearby.store, now: now),
                  ],
                ),
              ),
            ],
          ),
          ...nearby.store.address.match(
            () => const <Widget>[],
            (String address) => <Widget>[
              const SizedBox(height: MjSpacing.medium),
              Row(
                children: <Widget>[
                  const Icon(LucideIcons.mapPin, size: 18, color: MjColors.primary),
                  const SizedBox(width: MjSpacing.small),
                  Expanded(child: Text(address, style: MjTextStyles.body)),
                ],
              ),
            ],
          ),
          const SizedBox(height: MjSpacing.large),
          MjSectionTitle(title: t.stores.hours),
          const SizedBox(height: MjSpacing.small),
          nearby.store.openingHours.match(
            () => Text(t.stores.hoursUnknown, style: MjTextStyles.detail),
            (String raw) => parseOpeningHours(raw).match(
              () => Text(raw, style: MjTextStyles.body),
              (WeekHours hours) => StoreHoursTable(hours: hours, today: now.weekday),
            ),
          ),
          const SizedBox(height: MjSpacing.large),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(StoreSheetChoice.directions),
            icon: const Icon(LucideIcons.navigation),
            label: Text(t.stores.directions),
          ),
          const SizedBox(height: MjSpacing.fieldGap),
          Text(t.stores.sheetNote, textAlign: TextAlign.center, style: MjTextStyles.caption),
        ],
      ),
    ),
  );
}
