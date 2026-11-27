import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/household_edit_cubit.dart';
import 'package:mijoo/features/setup/presentation/widgets/household_edit_footer.dart';
import 'package:mijoo/features/setup/presentation/widgets/household_edit_form.dart';
import 'package:mijoo/features/setup/presentation/widgets/household_edit_header.dart';

class HouseholdEditScreen extends StatelessWidget {
  const HouseholdEditScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<HouseholdEditCubit, HouseholdEditState>(
    listener: (BuildContext context, HouseholdEditState state) => switch (state) {
      HouseholdEditSaved() => context.pop(),
      HouseholdEditEditing() || HouseholdEditSaving() || HouseholdEditFailed() => null,
    },
    builder: (BuildContext context, HouseholdEditState state) => MjPage(
      footer: some(HouseholdEditFooter(state: state)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HouseholdEditHeader(),
          const SizedBox(height: MjSpacing.large),
          ...switch (state) {
            HouseholdEditFailed(:final failure) => <Widget>[
              FailureView(failure: failure),
              const SizedBox(height: MjSpacing.large),
            ],
            HouseholdEditEditing() || HouseholdEditSaving() || HouseholdEditSaved() => const <Widget>[],
          },
          HouseholdEditForm(draft: state.draft),
        ],
      ),
    ),
  );
}
