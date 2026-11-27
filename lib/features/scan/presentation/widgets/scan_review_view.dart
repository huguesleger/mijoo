import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/presentation/bloc/scan_cubit.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_line_tile.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_review_header.dart';

class ScanReviewView extends StatelessWidget {
  const ScanReviewView({required this.review, super.key});

  final ScanReview review;

  @override
  Widget build(BuildContext context) {
    final int selected = review.selectedLines.length;
    return MjPage(
      footer: some(
        FilledButton(
          onPressed: selected == 0 ? null : context.read<ScanCubit>().save,
          child: Text(switch (selected) {
            0 => t.scan.addZero,
            1 => t.scan.addSingle,
            _ => t.scan.addSeveral(count: selected),
          }),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ScanReviewHeader(photo: review.photo, count: review.lines.length, uncertain: review.uncertainCount),
          const SizedBox(height: MjSpacing.medium),
          Align(
            alignment: Alignment.centerLeft,
            child: MjChoiceChip(
              label: review.allSelected ? t.scan.unselectAll : t.scan.selectAll,
              icon: some(review.allSelected ? LucideIcons.x : LucideIcons.checkCheck),
              selected: review.allSelected,
              onTap: context.read<ScanCubit>().selectAll,
            ),
          ),
          const SizedBox(height: MjSpacing.medium),
          for (final (int index, ScanLine line) in review.lines.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: ScanLineTile(index: index, line: line),
            ),
        ],
      ),
    );
  }
}
