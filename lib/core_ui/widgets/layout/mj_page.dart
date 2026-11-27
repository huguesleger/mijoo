import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjPage extends StatelessWidget {
  const MjPage({required this.child, this.footer = const None(), super.key});

  final Widget child;
  final Option<Widget> footer;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MjColors.background,
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: MjSpacing.contentWidth),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(MjSpacing.pageGutter),
            child: child,
          ),
        ),
      ),
    ),
    bottomNavigationBar: footer.match(
      () => null,
      (Widget footer) => SafeArea(
        minimum: const EdgeInsets.fromLTRB(
          MjSpacing.pageGutter,
          MjSpacing.small,
          MjSpacing.pageGutter,
          MjSpacing.medium,
        ),
        child: footer,
      ),
    ),
  );
}
