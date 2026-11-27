import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/presentation/bloc/scan_cubit.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_analyzing_view.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_failed_view.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_nothing_found_view.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_review_view.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_status_page.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<ScanCubit, ScanState>(
    listener: (BuildContext context, ScanState state) => switch (state) {
      ScanSaved() || ScanCancelled() => context.pop(),
      ScanTakingPhoto() ||
      ScanAnalyzing() ||
      ScanReview() ||
      ScanNothingFound() ||
      ScanSaving() ||
      ScanFailed() => null,
    },
    builder: (BuildContext context, ScanState state) => switch (state) {
      ScanTakingPhoto() || ScanSaving() || ScanSaved() || ScanCancelled() => const ScanStatusPage(
        child: Padding(padding: EdgeInsets.all(MjSpacing.extraLarge), child: MjLoader()),
      ),
      ScanAnalyzing(:final photo) => ScanAnalyzingView(photo: photo),
      final ScanReview review => ScanReviewView(review: review),
      ScanNothingFound() => const ScanStatusPage(child: ScanNothingFoundView()),
      ScanFailed(:final failure) => ScanStatusPage(
        child: ScanFailedView(failure: failure, onRetry: context.read<ScanCubit>().start),
      ),
    },
  );
}
