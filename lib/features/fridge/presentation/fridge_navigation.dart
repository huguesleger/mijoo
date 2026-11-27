import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice_sheet.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_item_sheet.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_kind.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_sheet_result.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/presentation/bloc/best_before_cubit.dart';

Future<FridgeSheetResult?> showFridgeItemSheet(
  BuildContext context, {
  required Option<FridgeItemInput> initial,
  required FridgeSheetKind kind,
}) => MjBottomSheet.show<FridgeSheetResult>(
  context,
  builder: (_) => BlocProvider<BestBeforeCubit>(
    create: (_) => BestBeforeCubit(),
    child: FridgeItemSheet(initial: initial, kind: kind),
  ),
);

Future<void> openFridgeItemSheet(BuildContext context, FridgeItem item) async {
  final FridgeCubit cubit = context.read<FridgeCubit>();
  final FridgeSheetResult? result = await showFridgeItemSheet(
    context,
    initial: some(item.input),
    kind: FridgeSheetKind.edit,
  );
  await switch (result) {
    FridgeSheetSaved(:final FridgeItemInput input) => cubit.updateItem(item.id, input),
    FridgeSheetDeleted() => cubit.deleteItem(item.id),
    null => Future<void>.value(),
  };
}

Future<void> openNewFridgeItemSheet(BuildContext context, Option<FridgeItemInput> prefill) async {
  final FridgeCubit cubit = context.read<FridgeCubit>();
  final FridgeSheetResult? result = await showFridgeItemSheet(context, initial: prefill, kind: FridgeSheetKind.add);
  await switch (result) {
    FridgeSheetSaved(:final FridgeItemInput input) => cubit.addItem(input),
    FridgeSheetDeleted() || null => Future<void>.value(),
  };
}

Future<void> openFridgeAddChoice(BuildContext context) async {
  final FridgeAddChoice? choice = await MjBottomSheet.show<FridgeAddChoice>(
    context,
    builder: (_) => const FridgeAddChoiceSheet(),
  );
  if (!context.mounted) return;
  await switch (choice) {
    FridgeAddChoice.fridgePhoto => const ScanPageRoute(source: PhotoSource.camera).push<void>(context),
    FridgeAddChoice.galleryPhoto => const ScanPageRoute(source: PhotoSource.gallery).push<void>(context),
    FridgeAddChoice.barcode => _scanBarcode(context),
    FridgeAddChoice.manual => openNewFridgeItemSheet(context, none()),
    null => Future<void>.value(),
  };
}

Future<void> _scanBarcode(BuildContext context) async {
  final Option<ScanProposal>? product = await const BarcodePageRoute().push<Option<ScanProposal>>(context);
  if (product == null || !context.mounted) return;
  await openNewFridgeItemSheet(context, product.map((ScanProposal proposal) => proposal.input));
}
