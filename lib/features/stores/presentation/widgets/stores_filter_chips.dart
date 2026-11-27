import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/store_filter.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoresFilterChips extends StatelessWidget {
  const StoresFilterChips({required this.selected, required this.onChanged, super.key});

  final StoreFilter selected;
  final ValueChanged<StoreFilter> onChanged;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    clipBehavior: Clip.none,
    child: Row(
      spacing: MjSpacing.small,
      children: <Widget>[
        for (final StoreFilter filter in StoreFilter.values)
          MjChoiceChip(
            label: filterLabel(filter),
            icon: filterIcon(filter),
            selected: filter == selected,
            onTap: () => onChanged(filter),
          ),
      ],
    ),
  );
}
