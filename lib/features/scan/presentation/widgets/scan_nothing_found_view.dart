import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/presentation/bloc/scan_cubit.dart';

class ScanNothingFoundView extends StatelessWidget {
  const ScanNothingFoundView({super.key});

  @override
  Widget build(BuildContext context) => MjMessageView(
    title: some(t.scan.nothingTitle),
    message: t.scan.nothingMessage,
    icon: some(LucideIcons.searchX),
    action: some(MjMessageAction(label: t.scan.retake, onPressed: context.read<ScanCubit>().start)),
    placement: MjMessagePlacement.tab,
  );
}
