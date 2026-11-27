import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_list.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_empty_view.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_reserved_section.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_section.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_summary.dart';

class ShoppingLoadedView extends StatelessWidget {
  const ShoppingLoadedView({required this.list, required this.state, super.key});

  final ShoppingList list;
  final ShoppingLoaded state;

  @override
  Widget build(BuildContext context) {
    final List<ShoppingLine> needs = list.lines.where((ShoppingLine line) => !line.manual).toList();
    final List<ShoppingLine> manual = list.lines.where((ShoppingLine line) => line.manual).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: MjSpacing.small,
      children: <Widget>[
        ShoppingSummary(
          toBuy: list.lines.where((ShoppingLine line) => !line.checked).length,
          inBasket: list.lines.where((ShoppingLine line) => line.checked).length,
          plannedMeals: list.plannedMeals,
        ),
        MjAddField(hint: t.shopping.addHint, addLabel: t.shopping.add, onAdd: context.read<ShoppingCubit>().add),
        ...state.writeFailure.match(() => const <Widget>[], (failure) => <Widget>[FailureView(failure: failure)]),
        if (list.lines.isEmpty && list.reservations.isEmpty) const ShoppingEmptyView(),
        for (final FridgeCategory category in FridgeCategory.values)
          if (needs.where((ShoppingLine line) => line.category == category).toList() case final List<ShoppingLine> lines
              when lines.isNotEmpty)
            ShoppingSection(
              title: t.fridge.categories[category.name] ?? category.name,
              icon: fridgeCategoryIcon(category),
              tone: fridgeCategoryTone(category),
              lines: lines,
            ),
        if (manual.isNotEmpty)
          ShoppingSection(title: t.shopping.manual, icon: LucideIcons.pencil, tone: MjTone.neutral, lines: manual),
        if (list.reservations.isNotEmpty) ShoppingReservedSection(reservations: list.reservations),
      ],
    );
  }
}
