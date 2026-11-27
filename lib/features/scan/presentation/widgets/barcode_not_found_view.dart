import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/presentation/bloc/barcode_cubit.dart';

class BarcodeNotFoundView extends StatelessWidget {
  const BarcodeNotFoundView({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      MjMessageView(
        title: some(t.scan.barcodeNotFoundTitle),
        message: t.scan.barcodeNotFoundMessage,
        icon: some(LucideIcons.packageSearch),
        action: some(
          MjMessageAction(
            label: t.scan.manual,
            onPressed: () => context.pop<Option<ScanProposal>>(none()),
          ),
        ),
      ),
      const SizedBox(height: MjSpacing.small),
      TextButton(onPressed: context.read<BarcodeCubit>().scanAgain, child: Text(t.scan.scanAgain)),
    ],
  );
}
