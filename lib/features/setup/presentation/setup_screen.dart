import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_done_content.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_editing_content.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SetupCubit, SetupState>(
    builder: (context, state) {
      final cubit = context.read<SetupCubit>();
      final step = switch (state) {
        SetupEditing(:final step) => some(step),
        SetupFailed() => some(SetupStep.budget),
        SetupSaving() || SetupDone() => none<SetupStep>(),
      };
      return DsSheetPage(
        onBack: step.filter((step) => step != SetupStep.household).map((_) => cubit.back),
        header: step.match(
          () => DsHeader(
            lead: t.setup.doneLead,
            highlight: t.setup.doneHighlight,
            subtitle: some(t.setup.doneSubtitle),
          ),
          (step) => switch (step) {
            SetupStep.household => DsHeader(
              lead: t.setup.householdLead,
              highlight: t.setup.householdHighlight,
              subtitle: some(t.setup.householdSubtitle),
            ),
            SetupStep.preferences => DsHeader(
              lead: t.setup.preferencesLead,
              highlight: t.setup.preferencesHighlight,
              subtitle: some(t.setup.preferencesSubtitle),
            ),
            SetupStep.budget => DsHeader(
              lead: t.setup.budgetLead,
              highlight: t.setup.budgetHighlight,
              subtitle: some(t.setup.budgetSubtitle),
            ),
          },
        ),
        child: switch (state) {
          SetupEditing(:final draft, :final step) => SetupEditingContent(
            draft: draft,
            step: step,
            failure: none(),
          ),
          SetupFailed(:final draft, :final failure) => SetupEditingContent(
            draft: draft,
            step: SetupStep.budget,
            failure: some(failure),
          ),
          SetupSaving() => const DsLoader(),
          SetupDone() => const SetupDoneContent(),
        },
      );
    },
  );
}
