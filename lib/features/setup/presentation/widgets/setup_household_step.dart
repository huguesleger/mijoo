import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_portions_summary.dart';
import 'package:mijoo/features/setup/presentation/widgets/setup_prep_time_tile.dart';

const List<int> _prepTimes = <int>[15, 30, 45, 60, 90];

class SetupHouseholdStep extends StatelessWidget {
  const SetupHouseholdStep({required this.draft, super.key});

  final SetupDraft draft;

  @override
  Widget build(BuildContext context) {
    final SetupCubit cubit = context.read<SetupCubit>();
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
          onChanged: (int adults) => cubit.update(adults: some(adults)),
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
          onChanged: (int children) => cubit.update(children: some(children)),
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
                  onTap: () => cubit.update(maxPrepMinutes: some(minutes)),
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
