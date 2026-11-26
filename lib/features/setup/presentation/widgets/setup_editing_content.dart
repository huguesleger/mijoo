import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_budget_step.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_household_step.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_preferences_step.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';

class SetupEditingContent extends StatelessWidget {
  const SetupEditingContent({
    required this.draft,
    required this.step,
    required this.failure,
    super.key,
  });

  final SetupDraft draft;
  final SetupStep step;
  final Option<AppFailure> failure;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DsStepProgress(
          current: step.index + 1,
          total: SetupStep.values.length,
          label: t.setup.step(
            current: step.index + 1,
            total: SetupStep.values.length,
          ),
        ),
        const SizedBox(height: DsSpacing.large),
        switch (step) {
          SetupStep.household => SetupHouseholdStep(draft: draft),
          SetupStep.preferences => SetupPreferencesStep(draft: draft),
          SetupStep.budget => SetupBudgetStep(draft: draft),
        },
        ...failure.match(
          () => const <Widget>[],
          (failure) => [
            const SizedBox(height: DsSpacing.medium),
            FailureView(failure: failure),
          ],
        ),
        const Spacer(),
        const SizedBox(height: DsSpacing.large),
        FilledButton(
          onPressed: cubit.canContinue(draft, step) ? cubit.next : null,
          child: Text(switch (step) {
            SetupStep.household || SetupStep.preferences => t.setup.kContinue,
            SetupStep.budget => t.setup.finish,
          }),
        ),
      ],
    );
  }
}
