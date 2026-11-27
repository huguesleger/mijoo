import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/presentation/bloc/best_before_cubit.dart';

class FridgeDateReadButton extends StatelessWidget {
  const FridgeDateReadButton({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BestBeforeCubit, BestBeforeState>(
    builder: (BuildContext context, BestBeforeState state) => Tooltip(
      message: t.scan.readDate,
      child: Material(
        color: MjColors.lavender,
        borderRadius: MjRadius.input,
        child: InkWell(
          borderRadius: MjRadius.input,
          onTap: switch (state) {
            BestBeforeReading() => null,
            BestBeforeIdle() ||
            BestBeforeRead() ||
            BestBeforeNotFound() ||
            BestBeforeFailed() => context.read<BestBeforeCubit>().read,
          },
          child: SizedBox(
            height: 52,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                spacing: MjSpacing.small,
                children: <Widget>[
                  switch (state) {
                    BestBeforeReading() => Semantics(
                      label: t.scan.readingDate,
                      child: const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    BestBeforeIdle() || BestBeforeRead() || BestBeforeNotFound() || BestBeforeFailed() => const Icon(
                      LucideIcons.scanText,
                      size: 19,
                      color: MjColors.ink,
                    ),
                  },
                  Text(t.scan.readDateShort, style: MjTextStyles.choice),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
