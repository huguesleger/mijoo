import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjPhotoCard extends StatelessWidget {
  const MjPhotoCard({required this.photo, required this.child, this.badge = const None(), this.onTap, super.key});

  static const double photoHeight = 132;

  final Widget photo;
  final Widget child;
  final Option<Widget> badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: MjColors.onInk,
    borderRadius: MjRadius.card,
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: MjRadius.card,
          border: Border.all(color: MjColors.cardBorder),
        ),
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
                    (Widget badge) => <Widget>[Positioned(left: 10, top: 10, child: badge)],
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(14, 12, 14, 14), child: child),
          ],
        ),
      ),
    ),
  );
}
