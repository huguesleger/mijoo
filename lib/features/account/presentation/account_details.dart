import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_card.dart';
import '../../../core_ui/ds_tokens.dart';
import '../../auth/domain/account.dart';

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
