import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class SetupChoiceSection<T extends Enum> extends StatelessWidget {
  const SetupChoiceSection({
    required this.title,
    required this.values,
    required this.labels,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String title;
  final List<T> values;
  final Map<String, String> labels;
  final Set<T> selected;
  final ValueChanged<Set<T>> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Semantics(
        header: true,
        child: Text(title, style: MjTextStyles.sectionTitle),
      ),
      const SizedBox(height: MjSpacing.small),
      Wrap(
        spacing: MjSpacing.small,
        runSpacing: MjSpacing.small,
        children: [
          for (final value in values)
            MjChoiceChip(
              label: labels[value.name] ?? value.name,
              selected: selected.contains(value),
              onTap: () => onChanged(
                selected.contains(value) ? selected.difference({value}) : selected.union({value}),
              ),
            ),
        ],
      ),
    ],
  );
}
