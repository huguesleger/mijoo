import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';

class FridgeCategoryFilter extends StatelessWidget {
  const FridgeCategoryFilter({required this.categories, required this.selected, super.key});

  final List<FridgeCategory> categories;
  final Option<FridgeCategory> selected;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    clipBehavior: Clip.none,
    child: Row(
      spacing: MjSpacing.small,
      children: <Widget>[
        MjChoiceChip(
          label: t.fridge.filterAll,
          selected: selected.isNone(),
          onTap: () => context.read<FridgeCubit>().filter(none()),
        ),
        for (final FridgeCategory category in categories)
          MjChoiceChip(
            label: t.fridge.shortCategories[category.name] ?? category.name,
            icon: some(fridgeCategoryIcon(category)),
            selected: selected == some(category),
            onTap: () => context.read<FridgeCubit>().filter(some(category)),
          ),
      ],
    ),
  );
}
