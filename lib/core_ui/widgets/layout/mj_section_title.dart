import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjSectionTitle extends StatelessWidget {
  const MjSectionTitle({required this.title, this.trailing = const None(), super.key});

  final String title;
  final Option<Widget> trailing;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(
        child: Semantics(header: true, child: Text(title, style: MjTextStyles.cardTitle)),
      ),
      ...trailing.match(() => const <Widget>[], (Widget trailing) => <Widget>[trailing]),
    ],
  );
}
