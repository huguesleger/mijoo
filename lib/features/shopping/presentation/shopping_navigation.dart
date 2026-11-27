import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_line_sheet.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_sheet_result.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_store_sheet.dart';

Future<void> openShoppingLineSheet(BuildContext context, ShoppingLine line) async {
  final ShoppingCubit cubit = context.read<ShoppingCubit>();
  final ShoppingLineSheetResult? result = await MjBottomSheet.show<ShoppingLineSheetResult>(
    context,
    builder: (_) => ShoppingLineSheet(line: line),
  );
  await switch (result) {
    ShoppingLineSaved(:final double quantity, :final FridgeCategory category) => cubit.save(line, quantity, category),
    ShoppingLineRemoved() => cubit.remove(line),
    null => Future<void>.value(),
  };
}

Future<void> openShoppingStoreSheet(BuildContext context, List<ShoppingLine> checked) async {
  final ShoppingCubit cubit = context.read<ShoppingCubit>();
  final ShoppingStoreConfirmed? result = await MjBottomSheet.show<ShoppingStoreConfirmed>(
    context,
    builder: (_) => ShoppingStoreSheet(checked: checked),
  );
  if (result case final ShoppingStoreConfirmed confirmed) await cubit.store(confirmed.toFridge, checked);
}
