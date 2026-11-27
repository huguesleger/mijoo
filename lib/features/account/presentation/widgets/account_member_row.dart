import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';

class AccountMemberRow extends StatelessWidget {
  const AccountMemberRow({required this.member, required this.isMe, super.key});

  final HouseholdMember member;
  final bool isMe;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isMe ? MjColors.peony : MjColors.lavender,
            shape: BoxShape.circle,
          ),
          child: Text(member.name.characters.first.toUpperCase(), style: MjTextStyles.cardTitle.copyWith(fontSize: 17)),
        ),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(member.name, style: MjTextStyles.itemTitle),
              Text(isMe ? t.account.you : t.account.member, style: MjTextStyles.detail.copyWith(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}
