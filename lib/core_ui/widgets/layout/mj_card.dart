import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCard extends StatelessWidget {
  const MjCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: MjColors.surface,
      borderRadius: MjRadius.card,
    ),
    child: Padding(
      padding: const EdgeInsets.all(MjSpacing.large),
      child: child,
    ),
  );
}
