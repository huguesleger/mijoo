import 'package:flutter/material.dart';

import 'assets/assets.gen.dart';
import 'ds_back_button.dart';
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
          child: DsBackButton(onPressed: onBack),
        ),
        ExcludeSemantics(
          child: Assets.logo.mijooLogo.svg(width: DsSpacing.sheetLogoWidth),
        ),
      ],
    ),
  );
}
