import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjSegmentedControl<T> extends StatelessWidget {
  const MjSegmentedControl({required this.options, required this.selected, required this.onChanged, super.key});

  final List<(T, String)> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(MjSpacing.extraSmall),
    decoration: const BoxDecoration(color: MjColors.field, borderRadius: BorderRadius.all(Radius.circular(99))),
    child: Row(
      children: <Widget>[
        for (final (T value, String label) in options)
          Expanded(
            child: Semantics(
              button: true,
              selected: value == selected,
              child: Material(
                color: value == selected ? MjColors.ink : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(99)),
                child: InkWell(
                  onTap: () => onChanged(value),
                  borderRadius: const BorderRadius.all(Radius.circular(99)),
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        label,
                        style: MjTextStyles.chip.copyWith(
                          fontSize: 13.5,
                          color: value == selected ? MjColors.onInk : MjColors.secondaryText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
