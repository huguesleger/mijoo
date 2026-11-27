import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_controls.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_failed_view.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_loaded_view.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_loading_view.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_no_town_view.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_top_bar.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) => MjPage(
    child: BlocBuilder<StoresCubit, StoresState>(
      builder: (BuildContext context, StoresState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const StoresTopBar(),
          const SizedBox(height: MjSpacing.medium),
          MjSegmentedControl<StoresView>(
            options: <(StoresView, String)>[(StoresView.list, t.stores.list), (StoresView.map, t.stores.map)],
            selected: state.choices.view,
            onChanged: context.read<StoresCubit>().changeView,
          ),
          const SizedBox(height: MjSpacing.medium),
          ...switch (state) {
            StoresNoTown() => const <Widget>[StoresNoTownView()],
            StoresLoading() => <Widget>[StoresControls(state: state), const StoresLoadingView()],
            StoresFailed(:final failure) => <Widget>[StoresControls(state: state), StoresFailedView(failure: failure)],
            final StoresLoaded loaded => <Widget>[StoresControls(state: state), StoresLoadedView(state: loaded)],
          },
        ],
      ),
    ),
  );
}
