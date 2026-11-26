import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjStepProgress extends StatelessWidget {
  const MjStepProgress({
    required this.current,
    required this.total,
    required this.label,
    super.key,
  });

  final int current;
  final int total;
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    excludeSemantics: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: MjTextStyles.fieldLabel),
        const SizedBox(height: MjSpacing.small),
        Row(
          children: [
            for (var step = 1; step <= total; step++) ...[
              if (step > 1) const SizedBox(width: 6),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 6,
                  decoration: BoxDecoration(
                    color: step <= current ? MjColors.lavenderStrong : MjColors.neutralChip,
                    borderRadius: MjRadius.pill,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}
