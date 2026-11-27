import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCodeBox extends StatelessWidget {
  const MjCodeBox({required this.character, required this.active, super.key});

  final String character;
  final bool active;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    width: 44,
    height: 56,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: active ? MjColors.onInk : MjColors.field,
      borderRadius: MjRadius.item,
      border: Border.all(color: active ? MjColors.primary : MjColors.cardBorder, width: 1.5),
    ),
    child: Text(character, style: MjTextStyles.stat.copyWith(fontSize: 24)),
  );
}
