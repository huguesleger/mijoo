import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option;
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCounter extends StatelessWidget {
  const MjCounter({
    required this.label,
    required this.detail,
    required this.icon,
    required this.tone,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.decreaseLabel,
    required this.increaseLabel,
    required this.onChanged,
    super.key,
  });

  final String label;
  final Option<String> detail;
  final IconData icon;
  final MjTone tone;
  final int value;
  final int minimum;
  final int maximum;
  final String decreaseLabel;
  final String increaseLabel;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: MjColors.onInk,
      borderRadius: MjRadius.item,
      border: Border.all(color: MjColors.cardBorder),
    ),
    child: Row(
      children: <Widget>[
        MjIconTile(icon: icon, tone: tone),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: MjTextStyles.cardTitle),
              ...detail.match(
                () => const <Widget>[],
                (String detail) => <Widget>[Text(detail, style: MjTextStyles.detail)],
              ),
            ],
          ),
        ),
        MjStepButton(
          icon: LucideIcons.minus,
          tooltip: '$decreaseLabel $label',
          onPressed: value > minimum ? () => onChanged(value - 1) : null,
        ),
        SizedBox(
          width: MjSpacing.extraLarge,
          child: Semantics(
            liveRegion: true,
            label: '$label $value',
            excludeSemantics: true,
            child: Text('$value', textAlign: TextAlign.center, style: MjTextStyles.stat.copyWith(fontSize: 22)),
          ),
        ),
        MjStepButton(
          icon: LucideIcons.plus,
          tooltip: '$increaseLabel $label',
          filled: true,
          onPressed: value < maximum ? () => onChanged(value + 1) : null,
        ),
      ],
    ),
  );
}
