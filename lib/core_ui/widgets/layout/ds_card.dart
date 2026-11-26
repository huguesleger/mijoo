import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsCard extends StatelessWidget {
  const DsCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: DsColors.surface,
      borderRadius: DsRadius.card,
    ),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.large),
      child: child,
    ),
  );
}
