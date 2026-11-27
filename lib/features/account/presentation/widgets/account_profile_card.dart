import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';

class AccountProfileCard extends StatelessWidget {
  const AccountProfileCard({required this.account, super.key});

  final Account account;

  @override
  Widget build(BuildContext context) {
    final String name = account.name.getOrElse(() => t.account.noName);
    return MjGradientCard(
      child: Row(
        children: <Widget>[
          Container(
            width: 62,
            height: 62,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: MjColors.onInk, shape: BoxShape.circle),
            child: Text(
              account.name.match(() => '', (String name) => name.characters.first.toUpperCase()),
              style: MjTextStyles.stat.copyWith(color: MjColors.peonyStrong),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: MjTextStyles.sheetTitle.copyWith(fontSize: 22)),
                Text(account.email, style: MjTextStyles.detail.copyWith(color: MjColors.ink)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
