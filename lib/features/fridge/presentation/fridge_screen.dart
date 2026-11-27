import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/fridge/presentation/fridge_bone_mock.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_empty_view.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_failed_view.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_header.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_loaded_view.dart';

class FridgeScreen extends StatelessWidget {
  const FridgeScreen({super.key});

  @override
  Widget build(BuildContext context) => MjPage(
    child: Padding(
      padding: const EdgeInsets.only(bottom: MjSpacing.navigationClearance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const FridgeHeader(),
          const SizedBox(height: MjSpacing.medium),
          BlocBuilder<FridgeCubit, FridgeState>(
            builder: (_, FridgeState state) => switch (state) {
              FridgeLoading() => MjSkeletonizer(
                child: FridgeLoadedView(
                  state: FridgeLoaded(
                    items: fridgeBoneMock,
                    query: '',
                    category: none(),
                    today: DateTime(2000),
                    writeFailure: none(),
                  ),
                ),
              ),
              final FridgeLoaded loaded =>
                loaded.items.isEmpty ? const FridgeEmptyView() : FridgeLoadedView(state: loaded),
              FridgeFailed(:final failure) => FridgeFailedView(failure: failure),
            },
          ),
        ],
      ),
    ),
  );
}
