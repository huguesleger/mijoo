import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsChoiceChip extends StatelessWidget {
  const DsChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: label,
    excludeSemantics: true,
    child: InkWell(
      onTap: onTap,
      borderRadius: DsRadius.pill,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? DsColors.lavender : DsColors.field,
          borderRadius: DsRadius.pill,
          border: Border.all(
            color: selected ? DsColors.lavenderStrong : DsColors.field,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(LucideIcons.check, size: 16, color: DsColors.ink),
              const SizedBox(width: 6),
            ],
            Text(label, style: DsTextStyles.choice),
          ],
        ),
      ),
    ),
  );
}
