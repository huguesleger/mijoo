import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ScanStatusPage extends StatelessWidget {
  const ScanStatusPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => MjPage(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: MjBackButton(onPressed: context.pop),
        ),
        const SizedBox(height: MjSpacing.medium),
        child,
      ],
    ),
  );
}
