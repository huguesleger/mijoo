import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core_ui/ds_tokens.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
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
                style: const TextStyle(color: DsColors.primary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: DsTextStyles.headline,
        ),
      ),
      ...subtitle.match(
        () => const <Widget>[],
        (subtitle) => [
          const SizedBox(height: DsSpacing.small),
          Text(subtitle, textAlign: TextAlign.center, style: DsTextStyles.body),
        ],
      ),
    ],
  );
}
