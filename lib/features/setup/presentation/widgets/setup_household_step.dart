import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_portions_summary.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_prep_time_tile.dart';

const List<int> _prepTimes = <int>[15, 30, 45, 60, 90];

class SetupHouseholdStep extends StatelessWidget {
  const SetupHouseholdStep({required this.draft, required this.onChanged, super.key});

  final SetupDraft draft;
  final ValueChanged<SetupDraft> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MjCounter(
          label: t.setup.adults,
          detail: some(t.setup.adultsDetail),
          icon: LucideIcons.userRound,
          tone: MjTone.lavender,
          value: draft.adults,
          minimum: 1,
          maximum: 12,
          decreaseLabel: t.setup.decrease,
          increaseLabel: t.setup.increase,
          onChanged: (int adults) => onChanged(draft.copyWith(adults: some(adults))),
        ),
        const SizedBox(height: 10),
        MjCounter(
          label: t.setup.children,
          detail: some(t.setup.childrenDetail),
          icon: LucideIcons.baby,
          tone: MjTone.peony,
          value: draft.children,
          minimum: 0,
          maximum: 12,
          decreaseLabel: t.setup.decrease,
          increaseLabel: t.setup.increase,
          onChanged: (int children) => onChanged(draft.copyWith(children: some(children))),
        ),
        const SizedBox(height: MjSpacing.large),
        Text(t.setup.prepTime, style: MjTextStyles.fieldLabel),
        const SizedBox(height: MjSpacing.small),
        Row(
          spacing: MjSpacing.small,
          children: <Widget>[
            for (final int minutes in _prepTimes)
              Expanded(
                child: SetupPrepTimeTile(
                  minutes: minutes,
                  selected: draft.maxPrepMinutes == minutes,
                  onTap: () => onChanged(draft.copyWith(maxPrepMinutes: some(minutes))),
                ),
              ),
          ],
        ),
        const SizedBox(height: MjSpacing.large),
        SetupPortionsSummary(people: draft.adults + draft.children, minutes: draft.maxPrepMinutes),
      ],
    );
  }
}
