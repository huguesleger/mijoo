import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/account/presentation/widgets/account_member_row.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';

class AccountMemberList extends StatelessWidget {
  const AccountMemberList({required this.state, super.key});

  final MembersLoaded state;

  @override
  Widget build(BuildContext context) => MjListCard(
    child: Column(
      children: <Widget>[
        for (final (int index, HouseholdMember member) in state.members.indexed) ...<Widget>[
          if (index > 0) const Divider(height: 1, color: MjColors.cardBorder),
          AccountMemberRow(member: member, isMe: member.id == state.me),
        ],
        if (state.members.length < 2) ...<Widget>[
          if (state.members.isNotEmpty) const Divider(height: 1, color: MjColors.cardBorder),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                const MjIconTile(icon: LucideIcons.userPlus, tone: MjTone.neutral, size: 42),
                const SizedBox(width: MjSpacing.fieldGap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(t.account.nobody, style: MjTextStyles.itemTitle.copyWith(color: MjColors.secondaryText)),
                      Text(t.account.nobodyDetail, style: MjTextStyles.detail.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}
