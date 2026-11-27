import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_choice_section.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';

class SetupPreferencesStep extends StatelessWidget {
  const SetupPreferencesStep({required this.draft, required this.onChanged, super.key});

  final SetupDraft draft;
  final ValueChanged<SetupDraft> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SetupChoiceSection(
          title: t.setup.likesTitle,
          values: FoodLike.values,
          labels: t.setup.likes,
          selected: draft.likes,
          onChanged: (likes) => onChanged(draft.copyWith(likes: some(likes))),
        ),
        const SizedBox(height: MjSpacing.large),
        SetupChoiceSection(
          title: t.setup.exclusionsTitle,
          values: FoodExclusion.values,
          labels: t.setup.exclusions,
          selected: draft.exclusions,
          onChanged: (exclusions) => onChanged(draft.copyWith(exclusions: some(exclusions))),
        ),
        const SizedBox(height: MjSpacing.large),
        SetupChoiceSection(
          title: t.setup.allergiesTitle,
          values: Allergen.values,
          labels: t.setup.allergens,
          selected: draft.allergies,
          onChanged: (allergies) => onChanged(draft.copyWith(allergies: some(allergies))),
        ),
      ],
    );
  }
}
