import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' show Some;

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/rules/invite_codes.dart';
import 'package:mijoo/features/setup/presentation/bloc/join_cubit.dart';

class JoinForm extends StatelessWidget {
  const JoinForm({required this.state, super.key});

  final JoinState state;

  @override
  Widget build(BuildContext context) {
    final JoinCubit cubit = context.read<JoinCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MjCodeField(
          label: t.setup.codeLabel,
          length: inviteLength,
          autofocus: true,
          initialValue: switch (state) {
            JoinEditing(:final String code) || JoinSending(:final String code) => code,
            JoinDone() => '',
          },
          onChanged: cubit.change,
        ),
        const SizedBox(height: MjSpacing.small),
        Text(t.setup.codeHelp, textAlign: TextAlign.center, style: MjTextStyles.caption),
        if (state case JoinEditing(failure: Some(value: final failure))) ...<Widget>[
          const SizedBox(height: MjSpacing.medium),
          FailureView(failure: failure),
        ],
        const Spacer(),
        const SizedBox(height: MjSpacing.large),
        switch (state) {
          JoinSending() || JoinDone() => const MjLoader(),
          JoinEditing() => FilledButton(onPressed: cubit.join, child: Text(t.setup.join)),
        },
      ],
    );
  }
}
