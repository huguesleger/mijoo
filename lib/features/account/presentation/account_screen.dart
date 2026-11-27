import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/bloc/account_cubit.dart';
import 'package:mijoo/features/account/presentation/widgets/account_household.dart';
import 'package:mijoo/features/account/presentation/widgets/account_profile_card.dart';
import 'package:mijoo/features/account/presentation/widgets/account_settings.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) => MjPage(
    child: BlocBuilder<AccountCubit, AccountState>(
      builder: (BuildContext context, AccountState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              MjBackButton(onPressed: context.pop),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(t.account.title, textAlign: TextAlign.center, style: MjTextStyles.cardTitle),
                ),
              ),
              const SizedBox(width: MjSpacing.tapTarget),
            ],
          ),
          const SizedBox(height: MjSpacing.large),
          AccountProfileCard(account: state.account),
          const SizedBox(height: MjSpacing.large),
          const AccountHousehold(),
          const SizedBox(height: MjSpacing.large),
          ...switch (state) {
            AccountSignOutFailed(:final failure) => <Widget>[
              FailureView(failure: failure),
              const SizedBox(height: MjSpacing.medium),
            ],
            AccountReady() || AccountSigningOut() => const <Widget>[],
          },
          switch (state) {
            AccountSigningOut() => const MjLoader(),
            AccountReady() || AccountSignOutFailed() => const AccountSettings(),
          },
        ],
      ),
    ),
  );
}
