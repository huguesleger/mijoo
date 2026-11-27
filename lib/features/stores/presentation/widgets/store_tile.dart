import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_opening_label.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({required this.nearby, required this.now, required this.onTap, super.key});

  final NearbyStore nearby;
  final DateTime now;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => MjListCard(
    onTap: onTap,
    child: Row(
      children: <Widget>[
        MjIconTile(icon: storeKindIcon(nearby.store.kind), tone: storeKindTone(nearby.store.kind)),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                storeName(nearby.store),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MjTextStyles.itemTitle,
              ),
              Text(
                nearby.store.address.match(
                  () => storeKindLabel(nearby.store.kind),
                  (String address) =>
                      t.stores.kindAndAddress(kind: storeKindLabel(nearby.store.kind), address: address),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MjTextStyles.detail,
              ),
              const SizedBox(height: 2),
              StoreOpeningLabel(store: nearby.store, now: now),
            ],
          ),
        ),
        const SizedBox(width: MjSpacing.small),
        Text(distanceLabel(nearby.meters), style: MjTextStyles.cardTitle.copyWith(fontSize: 14)),
      ],
    ),
  );
}
