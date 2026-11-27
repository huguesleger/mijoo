import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_position_choice.dart';

class StoresPositionSheet extends StatelessWidget {
  const StoresPositionSheet({required this.town, super.key});

  final Option<HouseholdLocation> town;

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: t.stores.consentTitle,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(t.stores.consentMessage, style: MjTextStyles.body),
        const SizedBox(height: MjSpacing.large),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(StoresPositionChoice.usePosition),
          icon: const Icon(LucideIcons.locateFixed),
          label: Text(t.stores.consentAccept),
        ),
        const SizedBox(height: MjSpacing.small),
        TextButton(
          onPressed: () => Navigator.of(context).pop(StoresPositionChoice.stay),
          child: Text(
            town.match(
              () => t.stores.consentCancel,
              (HouseholdLocation location) => t.stores.consentStay(city: location.city),
            ),
          ),
        ),
        const SizedBox(height: MjSpacing.small),
        Row(
          children: <Widget>[
            const Icon(LucideIcons.shieldCheck, size: 18, color: MjColors.success),
            const SizedBox(width: MjSpacing.small),
            Expanded(child: Text(t.stores.consentNote, style: MjTextStyles.caption)),
          ],
        ),
      ],
    ),
  );
}
