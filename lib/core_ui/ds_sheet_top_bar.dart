import 'package:flutter/material.dart';

import 'assets/assets.gen.dart';
import 'ds_tokens.dart';

class DsSheetTopBar extends StatelessWidget {
  const DsSheetTopBar({required this.onBack, super.key});

  final VoidCallback onBack;

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
        Align(
          alignment: Alignment.centerLeft,
          child: BackButton(
            onPressed: onBack,
            style: IconButton.styleFrom(
              backgroundColor: DsColors.surface,
              foregroundColor: DsColors.ink,
              fixedSize: const Size.square(DsSpacing.tapTarget),
            ),
          ),
        ),
        ExcludeSemantics(
          child: Assets.logo.mijooLogo.svg(width: DsSpacing.sheetLogoWidth),
        ),
      ],
    ),
  );
}
