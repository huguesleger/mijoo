import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class FridgeChoiceWrap<T extends Enum> extends StatelessWidget {
  const FridgeChoiceWrap({
    required this.title,
    required this.values,
    required this.labels,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String title;
  final List<T> values;
  final Map<String, String> labels;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: MjSpacing.extraSmall, bottom: MjSpacing.small),
        child: Text(title, style: MjTextStyles.fieldLabel),
      ),
      Wrap(
        spacing: MjSpacing.small,
        runSpacing: MjSpacing.small,
        children: <Widget>[
          for (final T value in values)
            MjChoiceChip(
              label: labels[value.name] ?? value.name,
              selected: value == selected,
              onTap: () => onSelected(value),
            ),
        ],
      ),
    ],
  );
}
