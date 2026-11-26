import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjLinkPrompt extends StatelessWidget {
  const MjLinkPrompt({
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
        style: MjTextStyles.caption,
        children: [
          TextSpan(
            text: action,
            style: MjTextStyles.button.copyWith(
              fontSize: 15,
              color: MjColors.ink,
            ),
          ),
        ],
      ),
    ),
  );
}
