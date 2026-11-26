import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';

const _prepTimes = [15, 30, 45, 60, 90];

class SetupHouseholdStep extends StatelessWidget {
  const SetupHouseholdStep({required this.draft, super.key});

  final SetupDraft draft;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DsCounter(
          label: t.setup.adults,
          value: draft.adults,
          minimum: 1,
          maximum: 12,
          decreaseLabel: t.setup.decrease,
          increaseLabel: t.setup.increase,
          onChanged: (adults) => cubit.update(adults: some(adults)),
        ),
        const SizedBox(height: DsSpacing.fieldGap),
        DsCounter(
          label: t.setup.children,
          value: draft.children,
          minimum: 0,
          maximum: 12,
          decreaseLabel: t.setup.decrease,
          increaseLabel: t.setup.increase,
          onChanged: (children) => cubit.update(children: some(children)),
        ),
        const SizedBox(height: DsSpacing.large),
        Text(t.setup.prepTime, style: DsTextStyles.sectionTitle),
        const SizedBox(height: DsSpacing.small),
        Wrap(
          spacing: DsSpacing.small,
          runSpacing: DsSpacing.small,
          children: [
            for (final minutes in _prepTimes)
              DsChoiceChip(
                label: t.setup.minutes(count: minutes),
                selected: draft.maxPrepMinutes == minutes,
                onTap: () => cubit.update(maxPrepMinutes: some(minutes)),
              ),
          ],
        ),
      ],
    );
  }
}
