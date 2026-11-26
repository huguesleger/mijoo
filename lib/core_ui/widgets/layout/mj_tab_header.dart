import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MjTabHeader extends StatelessWidget {
  const MjTabHeader({required this.title, required this.actions, super.key});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Row(
    spacing: MjSpacing.small,
    children: <Widget>[
      Expanded(
        child: Semantics(header: true, child: Text(title, style: MjTextStyles.headline)),
      ),
      ...actions,
    ],
  );
}
