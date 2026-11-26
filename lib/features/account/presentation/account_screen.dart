import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core/presentation/failure_view.dart';
import '../../../core_ui/ds_back_button.dart';
import '../../../core_ui/ds_loader.dart';
import '../../../core_ui/ds_page.dart';
import '../../../core_ui/ds_tokens.dart';
import '../../auth/presentation/auth_header.dart';
import 'account_cubit.dart';
import 'account_details.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) => DsPage(
    child: BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: DsBackButton(onPressed: context.pop),
          ),
          const SizedBox(height: DsSpacing.medium),
          AuthHeader(
            lead: t.account.titleLead,
            highlight: t.account.titleHighlight,
            subtitle: none(),
          ),
          const SizedBox(height: DsSpacing.large),
          AccountDetails(account: state.account),
          ...switch (state) {
            AccountSignOutFailed(:final failure) => [
              const SizedBox(height: DsSpacing.medium),
              FailureView(failure: failure),
            ],
            AccountReady() || AccountSigningOut() => const <Widget>[],
          },
          const SizedBox(height: DsSpacing.large),
          switch (state) {
            AccountSigningOut() => const DsLoader(),
            AccountReady() || AccountSignOutFailed() => OutlinedButton(
              onPressed: context.read<AccountCubit>().signOut,
              child: Text(t.account.signOut),
            ),
          },
        ],
      ),
    ),
  );
}
