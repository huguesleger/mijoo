import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MealLabelNote extends StatelessWidget {
  const MealLabelNote({required this.allergies, super.key});

  final List<String> allergies;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(color: MjTone.peony.surface, borderRadius: MjRadius.item),
    child: Row(
      children: <Widget>[
        Icon(LucideIcons.shieldAlert, size: 18, color: MjTone.peony.foreground),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            allergies.isEmpty ? t.meals.labelNote : t.meals.allergyNote,
            style: MjTextStyles.detail.copyWith(color: MjColors.ink, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
