import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjSheetPage extends StatelessWidget {
  const MjSheetPage({
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
          colors: [MjColors.heroPink, MjColors.heroLilac],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: MjSpacing.contentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MjSheetTopBar(onBack: onBack),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    MjSpacing.large,
                    MjSpacing.medium,
                    MjSpacing.large,
                    MjSpacing.large,
                  ),
                  child: header,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: MjColors.surface,
                      borderRadius: MjRadius.sheet,
                    ),
                    child: SafeArea(
                      top: false,
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.all(MjSpacing.large),
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
