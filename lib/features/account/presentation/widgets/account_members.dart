import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/account_navigation.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/account/presentation/widgets/account_member_list.dart';

class AccountMembers extends StatelessWidget {
  const AccountMembers({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HouseholdMembersCubit, HouseholdMembersState>(
    builder: (BuildContext context, HouseholdMembersState state) => switch (state) {
      MembersLoading() => const MjLoader(),
      MembersFailed(:final failure) => FailureView(failure: failure),
      final MembersLoaded loaded => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MjSectionTitle(
            title: t.account.members,
            trailing: some(
              Text(
                loaded.members.length == 1
                    ? t.account.membersSingle
                    : t.account.membersSeveral(count: loaded.members.length),
                style: MjTextStyles.detail,
              ),
            ),
          ),
          const SizedBox(height: MjSpacing.fieldGap),
          AccountMemberList(state: loaded),
          const SizedBox(height: MjSpacing.fieldGap),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: MjColors.lavender, foregroundColor: MjColors.ink),
            onPressed: () => openInviteSheet(context),
            icon: const Icon(LucideIcons.userPlus),
            label: Text(t.account.invite),
          ),
        ],
      ),
    },
  );
}
