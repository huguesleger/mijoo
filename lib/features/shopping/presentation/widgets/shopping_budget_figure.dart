import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ShoppingBudgetFigure extends StatelessWidget {
  const ShoppingBudgetFigure({
    required this.label,
    required this.value,
    this.detail = const None(),
    this.tone = const None(),
    this.valueTone = const None(),
    this.alignEnd = false,
    super.key,
  });

  final String label;
  final String value;
  final Option<String> detail;
  final Option<MjTone> tone;
  final Option<MjTone> valueTone;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...tone.match(
            () => const <Widget>[],
            (MjTone tone) => <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: tone.foreground, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
            ],
          ),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MjTextStyles.detail.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: MjTextStyles.cardTitle.copyWith(
          fontSize: 16,
          color: valueTone.match(() => MjColors.ink, (MjTone tone) => tone.foreground),
        ),
      ),
      ...detail.match(
        () => const <Widget>[],
        (String detail) => <Widget>[
          Text(detail, maxLines: 1, overflow: TextOverflow.ellipsis, style: MjTextStyles.detail.copyWith(fontSize: 10)),
        ],
      ),
    ],
  );
}
