import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoresRadiusChips extends StatelessWidget {
  const StoresRadiusChips({required this.selected, required this.onChanged, super.key});

  final StoreRadius selected;
  final ValueChanged<StoreRadius> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: MjSpacing.small,
    children: <Widget>[
      for (final StoreRadius radius in StoreRadius.values)
        MjChoiceChip(label: radiusLabel(radius), selected: radius == selected, onTap: () => onChanged(radius)),
    ],
  );
}
