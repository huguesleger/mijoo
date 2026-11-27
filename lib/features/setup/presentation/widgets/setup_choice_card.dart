import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class SetupChoiceCard extends StatelessWidget {
  const SetupChoiceCard({
    required this.icon,
    required this.title,
    required this.detail,
    required this.tone,
    required this.highlighted,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String detail;
  final MjTone tone;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: tone.surface,
    borderRadius: MjRadius.card,
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Ink(
        decoration: highlighted
            ? const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[MjColors.lavender, MjColors.peony]),
              )
            : null,
        padding: const EdgeInsets.all(18),
        child: Row(
          children: <Widget>[
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(color: MjColors.onInk, shape: BoxShape.circle),
              child: Icon(icon, color: highlighted ? MjColors.ink : tone.foreground),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: MjTextStyles.cardTitle),
                  const SizedBox(height: 2),
                  Text(detail, style: MjTextStyles.detail.copyWith(color: MjColors.ink)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: MjColors.ink),
          ],
        ),
      ),
    ),
  );
}
