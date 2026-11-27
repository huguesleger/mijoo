import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjProgressBar extends StatelessWidget {
  const MjProgressBar({required this.value, required this.label, super.key});

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    excludeSemantics: true,
    child: Container(
      height: 7,
      decoration: const BoxDecoration(color: MjColors.field, borderRadius: BorderRadius.all(Radius.circular(4))),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: value.clamp(0, 1),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            gradient: LinearGradient(colors: <Color>[MjColors.lavenderStrong, MjColors.peonyStrong]),
          ),
        ),
      ),
    ),
  );
}
