import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjStatCard extends StatelessWidget {
  const MjStatCard({required this.value, required this.label, required this.tone, super.key});

  final String value;
  final String label;
  final MjTone tone;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$value $label',
    excludeSemantics: true,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: MjSpacing.fieldGap),
      decoration: BoxDecoration(
        color: switch (tone) {
          MjTone.neutral => MjColors.onInk,
          MjTone.lavender || MjTone.peony || MjTone.apricot || MjTone.green || MjTone.glacier => tone.surface,
        },
        borderRadius: MjRadius.item,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: MjTextStyles.stat.copyWith(
              color: switch (tone) {
                MjTone.neutral => MjColors.ink,
                MjTone.lavender || MjTone.peony || MjTone.apricot || MjTone.green || MjTone.glacier => tone.foreground,
              },
            ),
          ),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.detail),
        ],
      ),
    ),
  );
}
