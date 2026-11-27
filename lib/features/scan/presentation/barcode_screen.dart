import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/presentation/bloc/barcode_cubit.dart';
import 'package:mijoo/features/scan/presentation/widgets/barcode_not_found_view.dart';
import 'package:mijoo/features/scan/presentation/widgets/barcode_scanner_view.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_failed_view.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) => MjPage(
    child: BlocConsumer<BarcodeCubit, BarcodeState>(
      listener: (BuildContext context, BarcodeState state) => switch (state) {
        BarcodeFound(:final ScanProposal product) => context.pop<Option<ScanProposal>>(some(product)),
        BarcodeScanning() || BarcodeSearching() || BarcodeNotFound() || BarcodeFailed() => null,
      },
      builder: (BuildContext context, BarcodeState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: MjBackButton(onPressed: context.pop),
          ),
          const SizedBox(height: MjSpacing.medium),
          MjHeader(
            lead: t.scan.barcodeTitleLead,
            highlight: t.scan.barcodeTitleHighlight,
            subtitle: some(t.scan.barcodeHint),
          ),
          const SizedBox(height: MjSpacing.large),
          switch (state) {
            BarcodeScanning() => const BarcodeScannerView(),
            BarcodeSearching() || BarcodeFound() => Semantics(
              liveRegion: true,
              label: t.scan.barcodeSearching,
              child: const Padding(padding: EdgeInsets.all(MjSpacing.extraLarge), child: MjLoader()),
            ),
            BarcodeNotFound() => const BarcodeNotFoundView(),
            BarcodeFailed(:final failure) => ScanFailedView(
              failure: failure,
              onRetry: context.read<BarcodeCubit>().scanAgain,
            ),
          },
        ],
      ),
    ),
  );
}
