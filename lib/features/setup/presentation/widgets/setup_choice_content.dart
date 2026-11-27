import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_choice_card.dart';

class SetupChoiceContent extends StatelessWidget {
  const SetupChoiceContent({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: MjSpacing.fieldGap,
    children: <Widget>[
      SetupChoiceCard(
        icon: LucideIcons.housePlus,
        title: t.setup.createTitle,
        detail: t.setup.createDetail,
        tone: MjTone.lavender,
        highlighted: true,
        onTap: context.read<SetupCubit>().create,
      ),
      SetupChoiceCard(
        icon: LucideIcons.keyRound,
        title: t.setup.joinTitle,
        detail: t.setup.joinDetail,
        tone: MjTone.apricot,
        highlighted: false,
        onTap: () => const JoinPageRoute().push<void>(context),
      ),
      MjMessageView(icon: some(LucideIcons.info), message: t.setup.noCode),
    ],
  );
}
