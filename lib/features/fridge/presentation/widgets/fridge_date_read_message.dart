import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/presentation/bloc/best_before_cubit.dart';

class FridgeDateReadMessage extends StatelessWidget {
  const FridgeDateReadMessage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BestBeforeCubit, BestBeforeState>(
    builder: (_, BestBeforeState state) => switch (state) {
      BestBeforeNotFound() => Padding(
        padding: const EdgeInsets.only(top: MjSpacing.small),
        child: Semantics(liveRegion: true, child: Text(t.scan.dateNotFound, style: MjTextStyles.caption)),
      ),
      BestBeforeFailed(:final failure) => Padding(
        padding: const EdgeInsets.only(top: MjSpacing.small),
        child: FailureView(failure: failure),
      ),
      BestBeforeIdle() || BestBeforeReading() || BestBeforeRead() => const SizedBox.shrink(),
    },
  );
}
