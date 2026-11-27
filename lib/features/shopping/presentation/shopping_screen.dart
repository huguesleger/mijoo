import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_list.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/shopping_bone_mock.dart';
import 'package:mijoo/features/shopping/presentation/shopping_navigation.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_failed_view.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_header.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_loaded_view.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ShoppingCubit, ShoppingState>(
    builder: (BuildContext context, ShoppingState state) {
      final Option<ShoppingList> list = switch (state) {
        ShoppingLoaded(:final facts) => some(shoppingList(facts)),
        ShoppingLoading() || ShoppingFailed() => none(),
      };
      final List<ShoppingLine> checked = list.match(
        () => const <ShoppingLine>[],
        (ShoppingList list) => list.lines.where((ShoppingLine line) => line.checked).toList(),
      );
      return MjPage(
        child: Padding(
          padding: const EdgeInsets.only(bottom: MjSpacing.navigationClearance),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ShoppingHeader(onStore: checked.isEmpty ? null : () => openShoppingStoreSheet(context, checked)),
              const SizedBox(height: MjSpacing.medium),
              switch (state) {
                ShoppingLoading() => MjSkeletonizer(
                  child: ShoppingLoadedView(
                    list: shoppingBoneMock,
                    state: ShoppingLoaded(
                      facts: (week: const [], items: const [], entries: const []),
                      writeFailure: none(),
                    ),
                  ),
                ),
                final ShoppingLoaded loaded => ShoppingLoadedView(
                  list: list.getOrElse(() => shoppingBoneMock),
                  state: loaded,
                ),
                ShoppingFailed(:final failure) => ShoppingFailedView(failure: failure),
              },
            ],
          ),
        ),
      );
    },
  );
}
