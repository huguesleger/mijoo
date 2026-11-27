import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjPhotoPage extends StatelessWidget {
  const MjPhotoPage({
    required this.photo,
    required this.onBack,
    required this.child,
    this.badge = const None(),
    this.footer = const None(),
    super.key,
  });

  static const double photoHeight = 330;
  static const double sheetOverlap = 34;

  final Widget photo;
  final VoidCallback onBack;
  final Widget child;
  final Option<Widget> badge;
  final Option<Widget> footer;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MjColors.surface,
    body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: photoHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    photo,
                    ...badge.match(
                      () => const <Widget>[],
                      (Widget badge) => <Widget>[
                        Positioned(right: MjSpacing.pageGutter, bottom: sheetOverlap + MjSpacing.small, child: badge),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -sheetOverlap),
                child: Container(
                  decoration: const BoxDecoration(color: MjColors.surface, borderRadius: MjRadius.sheet),
                  padding: const EdgeInsets.fromLTRB(
                    MjSpacing.pageGutter,
                    MjSpacing.large,
                    MjSpacing.pageGutter,
                    MjSpacing.small,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: MjSpacing.contentWidth),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(MjSpacing.pageGutter),
            child: MjBackButton(onPressed: onBack),
          ),
        ),
      ],
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
