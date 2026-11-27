import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class SetupPortionsSummary extends StatelessWidget {
  const SetupPortionsSummary({required this.people, required this.minutes, super.key});

  final int people;
  final int minutes;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: MjSpacing.medium, vertical: 14),
    decoration: BoxDecoration(color: MjTone.apricot.surface, borderRadius: MjRadius.item),
    child: Row(
      children: <Widget>[
        Icon(LucideIcons.users, size: 20, color: MjTone.apricot.foreground),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            people == 1
                ? t.setup.portionsSingle(minutes: minutes)
                : t.setup.portionsSeveral(count: people, minutes: minutes),
            style: MjTextStyles.detail.copyWith(color: MjColors.ink),
          ),
        ),
      ],
    ),
  );
}
