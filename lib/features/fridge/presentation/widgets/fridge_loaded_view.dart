import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_sections.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_filter.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_section_card.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_stats.dart';

class FridgeLoadedView extends StatelessWidget {
  const FridgeLoadedView({required this.state, super.key});

  final FridgeLoaded state;

  @override
  Widget build(BuildContext context) {
    final List<FridgeSection> sections = fridgeSections(state.items, state.query, state.category);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FridgeStats(items: state.items, today: state.today),
        const SizedBox(height: MjSpacing.medium),
        MjSearchField(hint: t.fridge.search, onChanged: context.read<FridgeCubit>().search),
        const SizedBox(height: MjSpacing.medium),
        FridgeCategoryFilter(categories: fridgeCategoriesInUse(state.items), selected: state.category),
        ...state.writeFailure.match(
          () => const <Widget>[],
          (AppFailure failure) => <Widget>[const SizedBox(height: MjSpacing.medium), FailureView(failure: failure)],
        ),
        const SizedBox(height: MjSpacing.large),
        if (sections.isEmpty)
          MjMessageView(
            title: some(t.fridge.noResultTitle),
            message: t.fridge.noResultMessage,
            icon: some(LucideIcons.searchX),
            placement: MjMessagePlacement.tab,
          ),
        for (final FridgeSection section in sections) ...<Widget>[
          FridgeSectionCard(section: section, today: state.today),
          const SizedBox(height: MjSpacing.medium),
        ],
      ],
    );
  }
}
