import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/domain/entities/stores_origin.dart';

class StoresOriginCard extends StatelessWidget {
  const StoresOriginCard({
    required this.origin,
    required this.town,
    required this.onUsePosition,
    required this.onUseTown,
    super.key,
  });

  final StoresOrigin origin;
  final Option<HouseholdLocation> town;
  final VoidCallback onUsePosition;
  final VoidCallback onUseTown;

  @override
  Widget build(BuildContext context) {
    final (String title, String subtitle, IconData icon) = switch ((origin, town)) {
      (StoresOrigin.town, Some(value: final HouseholdLocation location)) => (
        t.stores.townTitle(city: location.city, postalCode: location.postalCode),
        t.stores.townSubtitle,
        LucideIcons.mapPin,
      ),
      (StoresOrigin.position, _) || (StoresOrigin.town, None()) => (
        t.stores.positionTitle,
        t.stores.positionSubtitle,
        LucideIcons.locateFixed,
      ),
    };
    return MjListCard(
      child: Row(
        children: <Widget>[
          MjIconTile(icon: icon, tone: MjTone.lavender, size: 40),
          const SizedBox(width: MjSpacing.fieldGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.itemTitle),
                Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: MjTextStyles.detail),
              ],
            ),
          ),
          switch ((origin, town)) {
            (StoresOrigin.town, _) => TextButton.icon(
              style: TextButton.styleFrom(
                minimumSize: const Size(0, MjSpacing.tapTarget),
                textStyle: MjTextStyles.choice,
              ),
              onPressed: onUsePosition,
              icon: const Icon(LucideIcons.locateFixed, size: 16),
              label: Text(t.stores.usePosition),
            ),
            (StoresOrigin.position, Some()) => TextButton.icon(
              style: TextButton.styleFrom(
                minimumSize: const Size(0, MjSpacing.tapTarget),
                textStyle: MjTextStyles.choice,
              ),
              onPressed: onUseTown,
              icon: const Icon(LucideIcons.mapPin, size: 16),
              label: Text(t.stores.useTown),
            ),
            (StoresOrigin.position, None()) => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }
}
