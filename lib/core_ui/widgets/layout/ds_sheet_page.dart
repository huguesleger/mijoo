import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option;

import 'package:mijoo/core_ui/core_ui.dart';

class DsSheetPage extends StatelessWidget {
  const DsSheetPage({
    required this.onBack,
    required this.header,
    required this.child,
    super.key,
  });

  final Option<VoidCallback> onBack;
  final Widget header;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [DsColors.heroPink, DsColors.heroLilac],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: DsSpacing.contentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DsSheetTopBar(onBack: onBack),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    DsSpacing.large,
                    DsSpacing.medium,
                    DsSpacing.large,
                    DsSpacing.large,
                  ),
                  child: header,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: DsColors.surface,
                      borderRadius: DsRadius.sheet,
                    ),
                    child: SafeArea(
                      top: false,
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.all(DsSpacing.large),
                            sliver: SliverFillRemaining(
                              hasScrollBody: false,
                              child: child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
