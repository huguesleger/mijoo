import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjBackButton extends StatelessWidget {
  const MjBackButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    icon: const Icon(LucideIcons.chevronLeft),
    style: IconButton.styleFrom(
      backgroundColor: MjColors.surface,
      foregroundColor: MjColors.ink,
      fixedSize: const Size.square(MjSpacing.tapTarget),
    ),
  );
}
