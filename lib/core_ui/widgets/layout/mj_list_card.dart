import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjListCard extends StatelessWidget {
  const MjListCard({required this.child, this.onTap, super.key});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: MjColors.onInk,
    borderRadius: MjRadius.item,
    child: InkWell(
      onTap: onTap,
      borderRadius: MjRadius.item,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: MjRadius.item,
          border: Border.all(color: MjColors.cardBorder),
        ),
        child: Padding(padding: const EdgeInsets.all(MjSpacing.fieldGap), child: child),
      ),
    ),
  );
}
