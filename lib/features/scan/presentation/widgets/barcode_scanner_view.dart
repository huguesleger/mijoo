import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/domain/entities/barcode.dart';
import 'package:mijoo/features/scan/presentation/bloc/barcode_cubit.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide Barcode;

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const <BarcodeFormat>[BarcodeFormat.ean13, BarcodeFormat.ean8, BarcodeFormat.upcA, BarcodeFormat.upcE],
  );

  void _onDetect(BarcodeCapture capture) => switch (capture.barcodes
      .map((code) => code.rawValue ?? '')
      .where((String value) => value.isNotEmpty)
      .firstOrNull) {
    final String value => context.read<BarcodeCubit>().lookUp(Barcode(value)),
    null => null,
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: MjRadius.card,
    child: AspectRatio(
      aspectRatio: 3 / 4,
      child: MobileScanner(controller: _controller, onDetect: _onDetect),
    ),
  );
}
