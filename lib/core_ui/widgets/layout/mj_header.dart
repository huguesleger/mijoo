import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjHeader extends StatelessWidget {
  const MjHeader({
    required this.lead,
    required this.highlight,
    required this.subtitle,
    super.key,
  });

  final String lead;
  final String highlight;
  final Option<String> subtitle;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Semantics(
        header: true,
        child: Text.rich(
          TextSpan(
            text: lead,
            children: [
              TextSpan(
                text: highlight,
                style: const TextStyle(color: MjColors.primary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: MjTextStyles.headline,
        ),
      ),
      ...subtitle.match(
        () => const <Widget>[],
        (subtitle) => [
          const SizedBox(height: MjSpacing.small),
          Text(subtitle, textAlign: TextAlign.center, style: MjTextStyles.body),
        ],
      ),
    ],
  );
}
