import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCodeDisplay extends StatelessWidget {
  const MjCodeDisplay({required this.code, required this.label, super.key});

  final String code;
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    excludeSemantics: true,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 6,
      children: <Widget>[
        for (final String character in code.split(''))
          character == '-'
              ? Text('-', style: MjTextStyles.stat.copyWith(color: MjColors.placeholder))
              : Container(
                  width: 44,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: MjTone.lavender.surface, borderRadius: MjRadius.item),
                  child: Text(
                    character,
                    style: MjTextStyles.stat.copyWith(fontSize: 26, color: MjTone.lavender.foreground),
                  ),
                ),
      ],
    ),
  );
}
