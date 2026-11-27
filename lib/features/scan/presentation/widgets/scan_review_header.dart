import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ScanReviewHeader extends StatelessWidget {
  const ScanReviewHeader({required this.photo, required this.count, required this.uncertain, super.key});

  final Uint8List photo;
  final int count;
  final int uncertain;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: MjBackButton(onPressed: context.pop),
      ),
      const SizedBox(height: MjSpacing.medium),
      Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: MjRadius.item,
            child: Image.memory(photo, width: 78, height: 96, fit: BoxFit.cover, excludeFromSemantics: true),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Semantics(
                  header: true,
                  child: Text.rich(
                    TextSpan(
                      text: t.scan.reviewTitleLead,
                      children: <TextSpan>[
                        TextSpan(
                          text: t.scan.reviewTitleHighlight,
                          style: const TextStyle(color: MjColors.primary),
                        ),
                      ],
                    ),
                    style: MjTextStyles.headline.copyWith(fontSize: 27),
                  ),
                ),
                const SizedBox(height: MjSpacing.extraSmall),
                Text(
                  switch (uncertain) {
                    0 => t.scan.foundSure(count: count),
                    _ => t.scan.foundUncertain(count: count, uncertain: uncertain),
                  },
                  style: MjTextStyles.detail,
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
