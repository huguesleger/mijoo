import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';
import 'package:mijoo/features/stores/presentation/stores_navigation.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_filter_chips.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_origin_card.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_radius_chips.dart';

class StoresControls extends StatelessWidget {
  const StoresControls({required this.state, super.key});

  final StoresState state;

  @override
  Widget build(BuildContext context) {
    final StoresCubit cubit = context.read<StoresCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StoresOriginCard(
          origin: state.choices.origin,
          town: state.town,
          onUsePosition: () => askStoresPosition(context),
          onUseTown: cubit.useTown,
        ),
        const SizedBox(height: MjSpacing.fieldGap),
        StoresRadiusChips(selected: state.choices.radius, onChanged: cubit.changeRadius),
        const SizedBox(height: MjSpacing.small),
        StoresFilterChips(selected: state.choices.filter, onChanged: cubit.changeFilter),
        const SizedBox(height: MjSpacing.large),
      ],
    );
  }
}
