import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MjIconBadge extends StatelessWidget {
  const MjIconBadge({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 88,
      height: 88,
      decoration: const BoxDecoration(color: MjColors.lavender, shape: BoxShape.circle),
      child: Icon(icon, size: 40, color: MjColors.ink),
    ),
  );
}
