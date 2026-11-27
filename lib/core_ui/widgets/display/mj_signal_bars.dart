import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjSignalBars extends StatelessWidget {
  const MjSignalBars({required this.level, required this.maximum, required this.label, super.key});

  final int level;
  final int maximum;
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    excludeSemantics: true,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 2,
      children: <Widget>[
        for (int index = 0; index < maximum; index++)
          Container(
            width: 4,
            height: 9,
            decoration: BoxDecoration(
              color: index < level ? MjTone.green.foreground : MjColors.line,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ),
      ],
    ),
  );
}
