import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

class MealsConstraintsCard extends StatelessWidget {
  const MealsConstraintsCard({required this.profile, required this.toFinish, super.key});

  final HouseholdProfile profile;
  final int toFinish;

  @override
  Widget build(BuildContext context) {
    final List<String> restrictions = <String>[
      for (final String exclusion in profile.exclusions)
        t.meals.without(label: (t.setup.exclusions[exclusion] ?? exclusion).toLowerCase()),
      for (final String allergen in profile.allergies)
        t.meals.without(label: (t.setup.allergens[allergen] ?? allergen).toLowerCase()),
    ];
    return MjGradientCard(
      child: Row(
        children: <Widget>[
          const MjIconTile(icon: LucideIcons.sparkles, tone: MjTone.lavender, size: 42),
          const SizedBox(width: MjSpacing.fieldGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  profile.people == 1
                      ? t.meals.forOne(minutes: profile.maxPrepMinutes)
                      : t.meals.forSeveral(count: profile.people, minutes: profile.maxPrepMinutes),
                  style: MjTextStyles.cardTitle.copyWith(fontSize: 16),
                ),
                const SizedBox(height: MjSpacing.extraSmall),
                Text(
                  <String>[
                    if (restrictions.isEmpty) t.meals.noRestriction else ...restrictions,
                    if (toFinish == 1) t.meals.toFinishSingle,
                    if (toFinish > 1) t.meals.toFinishSeveral(count: toFinish),
                  ].join(' · '),
                  style: MjTextStyles.detail.copyWith(color: MjColors.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
