import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjIconTile extends StatelessWidget {
  const MjIconTile({required this.icon, required this.tone, this.size = MjSpacing.iconTile, super.key});

  final IconData icon;
  final MjTone tone;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: tone.surface, borderRadius: BorderRadius.circular(size / 3)),
    child: Icon(icon, size: size * 0.46, color: tone.foreground),
  );
}
