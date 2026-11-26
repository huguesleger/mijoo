import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCounter extends StatelessWidget {
  const MjCounter({
    required this.label,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.decreaseLabel,
    required this.increaseLabel,
    required this.onChanged,
    super.key,
  });

  final String label;
  final int value;
  final int minimum;
  final int maximum;
  final String decreaseLabel;
  final String increaseLabel;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(
      MjSpacing.medium,
      MjSpacing.small,
      MjSpacing.small,
      MjSpacing.small,
    ),
    decoration: const BoxDecoration(
      color: MjColors.field,
      borderRadius: MjRadius.field,
    ),
    child: Row(
      children: [
        Expanded(child: Text(label, style: MjTextStyles.fieldLabel)),
        IconButton(
          tooltip: '$decreaseLabel $label',
          onPressed: value > minimum ? () => onChanged(value - 1) : null,
          icon: const Icon(LucideIcons.minus),
          style: _style,
        ),
        SizedBox(
          width: MjSpacing.extraLarge,
          child: Semantics(
            liveRegion: true,
            label: '$label $value',
            excludeSemantics: true,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: MjTextStyles.counter,
            ),
          ),
        ),
        IconButton(
          tooltip: '$increaseLabel $label',
          onPressed: value < maximum ? () => onChanged(value + 1) : null,
          icon: const Icon(LucideIcons.plus),
          style: _style,
        ),
      ],
    ),
  );

  static final _style = IconButton.styleFrom(
    backgroundColor: MjColors.surface,
    foregroundColor: MjColors.ink,
    disabledBackgroundColor: MjColors.surface,
    disabledForegroundColor: MjColors.disabled,
    fixedSize: const Size.square(MjSpacing.tapTarget),
  );
}
