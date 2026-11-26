import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({required this.account, super.key});

  final Account account;

  @override
  Widget build(BuildContext context) => DsCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.account.name, style: DsTextStyles.fieldLabel),
        const SizedBox(height: DsSpacing.extraSmall),
        Text(
          account.name.getOrElse(() => t.account.noName),
          style: DsTextStyles.body,
        ),
        const SizedBox(height: DsSpacing.medium),
        Text(t.account.email, style: DsTextStyles.fieldLabel),
        const SizedBox(height: DsSpacing.extraSmall),
        Text(account.email, style: DsTextStyles.body),
      ],
    ),
  );
}
