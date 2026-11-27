import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjStepProgress extends StatelessWidget {
  const MjStepProgress({required this.current, required this.total, required this.label, super.key});

  final int current;
  final int total;
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    excludeSemantics: true,
    child: Row(
      children: <Widget>[
        for (int step = 1; step <= total; step++) ...<Widget>[
          if (step > 1) const SizedBox(width: 6),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 6,
              decoration: BoxDecoration(
                color: step <= current ? MjColors.ink : MjColors.neutralChip,
                borderRadius: MjRadius.pill,
              ),
            ),
          ),
        ],
        const SizedBox(width: MjSpacing.fieldGap),
        Text('$current/$total', style: MjTextStyles.detail.copyWith(fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
