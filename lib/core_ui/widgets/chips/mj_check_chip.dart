import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCheckChip extends StatelessWidget {
  const MjCheckChip({required this.label, required this.checked, super.key});

  final String label;
  final bool checked;

  @override
  Widget build(BuildContext context) => Semantics(
    checked: checked,
    label: label,
    excludeSemantics: true,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 26,
      padding: const EdgeInsets.only(left: 7, right: 10),
      decoration: BoxDecoration(
        color: checked ? MjColors.successSurface : MjColors.neutralChip,
        borderRadius: MjRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            checked ? LucideIcons.check : LucideIcons.circle,
            size: 15,
            color: checked ? MjColors.success : MjColors.neutralChipIcon,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: MjTextStyles.chip.copyWith(
              color: checked ? MjColors.success : MjColors.secondaryText,
            ),
          ),
        ],
      ),
    ),
  );
}
