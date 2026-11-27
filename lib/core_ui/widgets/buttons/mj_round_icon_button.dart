import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MjRoundIconButton extends StatelessWidget {
  const MjRoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.highlighted = false,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool highlighted;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    icon: Icon(icon),
    style: IconButton.styleFrom(
      backgroundColor: highlighted ? MjColors.lavender : MjColors.surface,
      foregroundColor: MjColors.ink,
      fixedSize: const Size.square(MjSpacing.tapTarget),
    ),
  );
}
