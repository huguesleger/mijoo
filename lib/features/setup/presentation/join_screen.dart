import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/join_cubit.dart';
import 'package:mijoo/features/setup/presentation/widgets/join_form.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<JoinCubit, JoinState>(
    builder: (BuildContext context, JoinState state) => MjSheetPage(
      onBack: switch (state) {
        JoinEditing() => some(context.pop),
        JoinSending() || JoinDone() => none(),
      },
      header: MjHeader(
        lead: t.setup.joinLead,
        highlight: t.setup.joinHighlight,
        subtitle: some(t.setup.joinSubtitle),
      ),
      child: JoinForm(state: state),
    ),
  );
}
