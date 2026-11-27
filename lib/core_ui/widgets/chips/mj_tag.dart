import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjTag extends StatelessWidget {
  const MjTag({required this.label, required this.tone, this.icon = const None(), super.key});

  final String label;
  final MjTone tone;
  final Option<IconData> icon;

  @override
  Widget build(BuildContext context) => Container(
    height: 26,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(color: tone.surface, borderRadius: MjRadius.pill),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ...icon.match(
          () => const <Widget>[],
          (IconData icon) => <Widget>[Icon(icon, size: 13, color: tone.foreground), const SizedBox(width: 5)],
        ),
        Text(label, style: MjTextStyles.tag.copyWith(color: tone.foreground)),
      ],
    ),
  );
}
