import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjChoiceChip extends StatelessWidget {
  const MjChoiceChip({
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
      borderRadius: MjRadius.pill,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? MjColors.lavender : MjColors.field,
          borderRadius: MjRadius.pill,
          border: Border.all(
            color: selected ? MjColors.lavenderStrong : MjColors.field,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(LucideIcons.check, size: 16, color: MjColors.ink),
              const SizedBox(width: 6),
            ],
            Text(label, style: MjTextStyles.choice),
          ],
        ),
      ),
    ),
  );
}
