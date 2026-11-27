import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjInfoTile extends StatelessWidget {
  const MjInfoTile({required this.icon, required this.label, required this.value, required this.tone, super.key});

  final IconData icon;
  final String label;
  final String value;
  final MjTone tone;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$label $value',
    excludeSemantics: true,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: MjSpacing.extraSmall, vertical: 10),
      decoration: BoxDecoration(color: tone.surface, borderRadius: MjRadius.item),
      child: Column(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(color: MjColors.onInk, shape: BoxShape.circle),
            child: Icon(icon, size: 15, color: tone.foreground),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: MjTextStyles.detail.copyWith(fontSize: 10.5),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: MjTextStyles.cardTitle.copyWith(fontSize: 15),
          ),
        ],
      ),
    ),
  );
}
