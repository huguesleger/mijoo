import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjStepButton extends StatelessWidget {
  const MjStepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.filled = false,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    icon: Icon(icon, size: 20),
    style: IconButton.styleFrom(
      backgroundColor: filled ? MjColors.ink : MjColors.onInk,
      foregroundColor: filled ? MjColors.onInk : MjColors.ink,
      disabledBackgroundColor: MjColors.field,
      disabledForegroundColor: MjColors.disabled,
      fixedSize: const Size.square(44),
      side: filled ? BorderSide.none : const BorderSide(color: MjColors.cardBorder),
    ),
  );
}
