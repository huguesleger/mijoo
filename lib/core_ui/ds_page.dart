import 'package:flutter/material.dart';

import 'ds_tokens.dart';

class DsPage extends StatelessWidget {
  const DsPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: DsColors.background,
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: DsSpacing.contentWidth),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(DsSpacing.large),
            child: child,
          ),
        ),
      ),
    ),
  );
}
