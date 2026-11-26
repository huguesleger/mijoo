import 'package:flutter/material.dart';

import 'ds_tokens.dart';

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
