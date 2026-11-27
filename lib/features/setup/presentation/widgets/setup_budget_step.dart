import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/rules/household_inputs.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';

class SetupBudgetStep extends StatelessWidget {
  const SetupBudgetStep({required this.draft, required this.onChanged, super.key});

  final SetupDraft draft;
  final ValueChanged<SetupDraft> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MjTextField(
          label: t.setup.weeklyBudget,
          hint: t.setup.weeklyBudgetHint,
          icon: LucideIcons.wallet,
          initialValue: draft.budget,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          suffixText: some(t.setup.euro),
          error: parseWeeklyBudgetCents(draft.budget).isNone() ? some(t.setup.budgetInvalid) : none(),
          onChanged: (budget) => onChanged(draft.copyWith(budget: some(budget))),
        ),
        const SizedBox(height: MjSpacing.large),
        MjTextField(
          label: t.setup.postalCode,
          hint: t.setup.postalCodeHint,
          icon: LucideIcons.mapPin,
          initialValue: draft.postalCode,
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.postalCode],
          error: isValidPostalCode(draft.postalCode) ? none() : some(t.setup.postalCodeInvalid),
          onChanged: (postalCode) => onChanged(draft.copyWith(postalCode: some(postalCode))),
        ),
        const SizedBox(height: MjSpacing.fieldGap),
        MjTextField(
          label: t.setup.city,
          hint: t.setup.cityHint,
          icon: LucideIcons.building2,
          initialValue: draft.city,
          autofillHints: const [AutofillHints.addressCity],
          onChanged: (city) => onChanged(draft.copyWith(city: some(city))),
        ),
        const SizedBox(height: MjSpacing.small),
        Text(t.setup.locationHelp, style: MjTextStyles.caption),
      ],
    );
  }
}
