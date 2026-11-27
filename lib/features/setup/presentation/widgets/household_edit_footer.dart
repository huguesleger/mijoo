import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/household_edit_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';

class HouseholdEditFooter extends StatelessWidget {
  const HouseholdEditFooter({required this.state, super.key});

  final HouseholdEditState state;

  @override
  Widget build(BuildContext context) => switch (state) {
    HouseholdEditSaving() || HouseholdEditSaved() => const MjLoader(),
    HouseholdEditEditing(:final draft) || HouseholdEditFailed(:final draft) => FilledButton(
      onPressed: isCompleteSetupDraft(draft) ? context.read<HouseholdEditCubit>().save : null,
      child: Text(t.setup.save),
    ),
  };
}
