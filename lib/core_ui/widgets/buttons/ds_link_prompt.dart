import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsLinkPrompt extends StatelessWidget {
  const DsLinkPrompt({
    required this.prompt,
    required this.action,
    required this.onPressed,
    super.key,
  });

  final String prompt;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    child: Text.rich(
      TextSpan(
        text: prompt,
        style: DsTextStyles.caption,
        children: [
          TextSpan(
            text: action,
            style: DsTextStyles.button.copyWith(
              fontSize: 15,
              color: DsColors.ink,
            ),
          ),
        ],
      ),
    ),
  );
}
