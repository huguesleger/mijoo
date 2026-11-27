import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class AccountHouseholdTile extends StatelessWidget {
  const AccountHouseholdTile({
    required this.icon,
    required this.tone,
    required this.value,
    required this.detail,
    super.key,
  });

  final IconData icon;
  final MjTone tone;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: MjColors.onInk,
      borderRadius: MjRadius.item,
      border: Border.all(color: MjColors.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MjIconTile(icon: icon, tone: tone, size: 38),
        const Spacer(),
        Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.cardTitle.copyWith(fontSize: 17)),
        Text(detail, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.detail),
      ],
    ),
  );
}
