import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/failure_message.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';

class FridgeFailedView extends StatelessWidget {
  const FridgeFailedView({required this.failure, super.key});

  final AppFailure failure;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: MjMessageView(
      message: failureMessage(failure),
      icon: some(LucideIcons.cloudAlert),
      action: some(MjMessageAction(label: t.fridge.retry, onPressed: context.read<FridgeCubit>().watch)),
      placement: MjMessagePlacement.tab,
    ),
  );
}
