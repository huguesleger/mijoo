import 'package:flutter/material.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class SetupPrepTimeTile extends StatelessWidget {
  const SetupPrepTimeTile({required this.minutes, required this.selected, required this.onTap, super.key});

  final int minutes;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: t.setup.minutes(count: minutes),
    excludeSemantics: true,
    child: Material(
      color: selected ? MjColors.ink : MjColors.field,
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$minutes',
                style: MjTextStyles.cardTitle.copyWith(color: selected ? MjColors.onInk : MjColors.ink),
              ),
              Text(
                t.setup.minutesUnit,
                style: MjTextStyles.detail.copyWith(
                  fontSize: 11,
                  color: selected ? MjColors.onInk : MjColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
