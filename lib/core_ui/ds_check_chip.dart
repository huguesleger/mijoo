import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'ds_tokens.dart';

class DsCheckChip extends StatelessWidget {
  const DsCheckChip({required this.label, required this.checked, super.key});

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
        color: checked ? DsColors.successSurface : DsColors.neutralChip,
        borderRadius: DsRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            checked ? LucideIcons.check : LucideIcons.circle,
            size: 15,
            color: checked ? DsColors.success : DsColors.neutralChipIcon,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: DsTextStyles.chip.copyWith(
              color: checked ? DsColors.success : DsColors.secondaryText,
            ),
          ),
        ],
      ),
    ),
  );
}
