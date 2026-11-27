import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/account_navigation.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';

class AccountLeaveRow extends StatelessWidget {
  const AccountLeaveRow({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HouseholdMembersCubit, HouseholdMembersState>(
    builder: (BuildContext context, HouseholdMembersState state) => switch (state) {
      MembersLoaded(leaving: Leaving()) => const MjLoader(),
      MembersLoaded() || MembersLoading() || MembersFailed() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: MjSpacing.small,
        children: <Widget>[
          if (state case MembersLoaded(leaving: LeaveFailed(:final failure))) FailureView(failure: failure),
          MjListCard(
            onTap: () => confirmLeave(context),
            child: Row(
              children: <Widget>[
                const Icon(LucideIcons.doorOpen, color: MjColors.error),
                const SizedBox(width: MjSpacing.fieldGap),
                Expanded(
                  child: Text(t.account.leave, style: MjTextStyles.itemTitle.copyWith(color: MjColors.error)),
                ),
              ],
            ),
          ),
        ],
      ),
    },
  );
}
