import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjChoiceChip extends StatelessWidget {
  const MjChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon = const None(),
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Option<IconData> icon;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: label,
    excludeSemantics: true,
    child: InkWell(
      onTap: onTap,
      borderRadius: MjRadius.pill,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: selected ? MjColors.ink : MjColors.onInk,
          borderRadius: MjRadius.pill,
          border: Border.all(color: selected ? MjColors.ink : MjColors.cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...icon.match(
              () => const <Widget>[],
              (IconData icon) => <Widget>[
                Icon(icon, size: 16, color: selected ? MjColors.onInk : MjColors.secondaryText),
                const SizedBox(width: 6),
              ],
            ),
            Text(label, style: MjTextStyles.choice.copyWith(color: selected ? MjColors.onInk : MjColors.ink)),
          ],
        ),
      ),
    ),
  );
}
