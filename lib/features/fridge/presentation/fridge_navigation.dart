import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_item_sheet.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_result.dart';

Future<void> openFridgeItemSheet(BuildContext context, Option<FridgeItem> item) async {
  final FridgeCubit cubit = context.read<FridgeCubit>();
  final FridgeSheetResult? result = await MjBottomSheet.show<FridgeSheetResult>(
    context,
    builder: (_) => FridgeItemSheet(initial: item),
  );
  await switch (result) {
    FridgeSheetSaved(:final FridgeItemInput input) => item.match(
      () => cubit.addItem(input),
      (FridgeItem item) => cubit.updateItem(item.id, input),
    ),
    FridgeSheetDeleted() => item.match(() => Future<void>.value(), (FridgeItem item) => cubit.deleteItem(item.id)),
    null => Future<void>.value(),
  };
}
