import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option;

import 'package:mijoo/core_ui/core_ui.dart';

class DsSheetTopBar extends StatelessWidget {
  const DsSheetTopBar({required this.onBack, super.key});

  final Option<VoidCallback> onBack;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      DsSpacing.medium,
      DsSpacing.small,
      DsSpacing.medium,
      0,
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        ...onBack.match(
          () => const [SizedBox(height: DsSpacing.tapTarget)],
          (onBack) => [
            Align(
              alignment: Alignment.centerLeft,
              child: DsBackButton(onPressed: onBack),
            ),
          ],
        ),
        ExcludeSemantics(
          child: Assets.logo.mijooLogo.svg(width: DsSpacing.sheetLogoWidth),
        ),
      ],
    ),
  );
}
