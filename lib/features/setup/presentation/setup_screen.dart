import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_choice_content.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_done_content.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_editing_content.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_header.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SetupCubit, SetupState>(
    builder: (context, state) {
      final cubit = context.read<SetupCubit>();
      return MjSheetPage(
        onBack: switch (state) {
          SetupEditing() || SetupFailed() => some(cubit.back),
          SetupChoosing() || SetupSaving() || SetupDone() => none(),
        },
        header: SetupHeader(state: state),
        child: switch (state) {
          SetupChoosing() => const SetupChoiceContent(),
          SetupEditing(:final draft, :final step) => SetupEditingContent(draft: draft, step: step, failure: none()),
          SetupFailed(:final draft, :final failure) => SetupEditingContent(
            draft: draft,
            step: SetupStep.budget,
            failure: some(failure),
          ),
          SetupSaving() => const MjLoader(),
          SetupDone() => const SetupDoneContent(),
        },
      );
    },
  );
}
