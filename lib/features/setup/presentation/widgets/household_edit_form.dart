import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/household_edit_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_budget_step.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_household_step.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_preferences_step.dart';

class HouseholdEditForm extends StatelessWidget {
  const HouseholdEditForm({required this.draft, super.key});

  final SetupDraft draft;

  @override
  Widget build(BuildContext context) {
    final HouseholdEditCubit cubit = context.read<HouseholdEditCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MjSectionTitle(title: t.setup.editComposition),
        const SizedBox(height: MjSpacing.fieldGap),
        SetupHouseholdStep(draft: draft, onChanged: cubit.change),
        const SizedBox(height: MjSpacing.extraLarge),
        MjSectionTitle(title: t.setup.editPreferences),
        const SizedBox(height: MjSpacing.fieldGap),
        SetupPreferencesStep(draft: draft, onChanged: cubit.change),
        const SizedBox(height: MjSpacing.extraLarge),
        MjSectionTitle(title: t.setup.editBudget),
        const SizedBox(height: MjSpacing.fieldGap),
        SetupBudgetStep(draft: draft, onChanged: cubit.change),
      ],
    );
  }
}
