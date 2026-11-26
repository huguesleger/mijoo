import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_choice_section.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';

class SetupPreferencesStep extends StatelessWidget {
  const SetupPreferencesStep({required this.draft, super.key});

  final SetupDraft draft;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SetupChoiceSection(
          title: t.setup.likesTitle,
          values: FoodLike.values,
          labels: t.setup.likes,
          selected: draft.likes,
          onChanged: (likes) => cubit.update(likes: some(likes)),
        ),
        const SizedBox(height: DsSpacing.large),
        SetupChoiceSection(
          title: t.setup.exclusionsTitle,
          values: FoodExclusion.values,
          labels: t.setup.exclusions,
          selected: draft.exclusions,
          onChanged: (exclusions) => cubit.update(exclusions: some(exclusions)),
        ),
        const SizedBox(height: DsSpacing.large),
        SetupChoiceSection(
          title: t.setup.allergiesTitle,
          values: Allergen.values,
          labels: t.setup.allergens,
          selected: draft.allergies,
          onChanged: (allergies) => cubit.update(allergies: some(allergies)),
        ),
      ],
    );
  }
}
