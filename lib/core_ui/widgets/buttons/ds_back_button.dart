import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsBackButton extends StatelessWidget {
  const DsBackButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    icon: const Icon(LucideIcons.chevronLeft),
    style: IconButton.styleFrom(
      backgroundColor: DsColors.surface,
      foregroundColor: DsColors.ink,
      fixedSize: const Size.square(DsSpacing.tapTarget),
    ),
  );
}
