import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjGradientCard extends StatelessWidget {
  const MjGradientCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[MjColors.lavender, MjColors.peony],
      ),
      borderRadius: MjRadius.card,
    ),
    child: Padding(padding: const EdgeInsets.all(MjSpacing.pageGutter), child: child),
  );
}
