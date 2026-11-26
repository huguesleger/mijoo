import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsHeroPage extends StatelessWidget {
  const DsHeroPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [DsColors.heroPink, DsColors.heroLilac, DsColors.surface],
          stops: [0, 0.42, 0.7],
        ),
      ),
      child: SizedBox.expand(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: DsSpacing.contentWidth,
              ),
              child: LayoutBuilder(
                builder: (_, constraints) => SingleChildScrollView(
                  padding: const EdgeInsets.all(DsSpacing.large),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - DsSpacing.large * 2,
                    ),
                    child: IntrinsicHeight(child: child),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
