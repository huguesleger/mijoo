import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCheckCircle extends StatelessWidget {
  const MjCheckCircle({required this.checked, super.key});

  final bool checked;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 180),
    width: 26,
    height: 26,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: checked ? MjColors.ink : Colors.transparent,
      border: Border.all(color: checked ? MjColors.ink : MjColors.line, width: 2),
    ),
    child: checked ? const Icon(LucideIcons.check, size: 15, color: MjColors.onInk) : null,
  );
}
