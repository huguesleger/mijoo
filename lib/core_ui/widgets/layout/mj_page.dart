import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjPage extends StatelessWidget {
  const MjPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MjColors.background,
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: MjSpacing.contentWidth),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(MjSpacing.large),
            child: child,
          ),
        ),
      ),
    ),
  );
}
