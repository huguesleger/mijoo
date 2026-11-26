import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjSheetTopBar extends StatelessWidget {
  const MjSheetTopBar({required this.onBack, super.key});

  final Option<VoidCallback> onBack;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      MjSpacing.medium,
      MjSpacing.small,
      MjSpacing.medium,
      0,
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        ...onBack.match(
          () => const [SizedBox(height: MjSpacing.tapTarget)],
          (onBack) => [
            Align(
              alignment: Alignment.centerLeft,
              child: MjBackButton(onPressed: onBack),
            ),
          ],
        ),
        ExcludeSemantics(
          child: Assets.logo.mijooLogo.svg(width: MjSpacing.sheetLogoWidth),
        ),
      ],
    ),
  );
}
