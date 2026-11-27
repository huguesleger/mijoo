import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';

class SetupHeader extends StatelessWidget {
  const SetupHeader({required this.state, super.key});

  final SetupState state;

  @override
  Widget build(BuildContext context) => switch (state) {
    SetupChoosing() => MjHeader(
      lead: t.setup.chooseLead,
      highlight: t.setup.chooseHighlight,
      subtitle: some(t.setup.chooseSubtitle),
    ),
    SetupEditing(step: SetupStep.household) => MjHeader(
      lead: t.setup.householdLead,
      highlight: t.setup.householdHighlight,
      subtitle: some(t.setup.householdSubtitle),
    ),
    SetupEditing(step: SetupStep.preferences) => MjHeader(
      lead: t.setup.preferencesLead,
      highlight: t.setup.preferencesHighlight,
      subtitle: some(t.setup.preferencesSubtitle),
    ),
    SetupEditing(step: SetupStep.budget) || SetupFailed() => MjHeader(
      lead: t.setup.budgetLead,
      highlight: t.setup.budgetHighlight,
      subtitle: some(t.setup.budgetSubtitle),
    ),
    SetupSaving() || SetupDone() => MjHeader(
      lead: t.setup.doneLead,
      highlight: t.setup.doneHighlight,
      subtitle: some(t.setup.doneSubtitle),
    ),
  };
}
