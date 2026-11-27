import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/bloc/account_cubit.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) => MjListCard(
    onTap: context.read<AccountCubit>().signOut,
    child: Row(
      children: <Widget>[
        const Icon(LucideIcons.logOut, color: MjColors.error),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Text(t.account.signOut, style: MjTextStyles.itemTitle.copyWith(color: MjColors.error)),
        ),
      ],
    ),
  );
}
