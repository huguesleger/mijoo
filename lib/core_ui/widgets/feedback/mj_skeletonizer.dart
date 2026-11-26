import 'package:flutter/widgets.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MjSkeletonizer extends StatelessWidget {
  const MjSkeletonizer({required this.child, this.enabled = true, super.key});

  final Widget child;
  final bool enabled;

  static const Duration minDuration = Duration(milliseconds: 500);

  static const ShimmerEffect _shimmer = ShimmerEffect(
    baseColor: MjColors.neutralChip,
    highlightColor: MjColors.surface,
    duration: Duration(milliseconds: 900),
  );

  @override
  Widget build(BuildContext context) => Skeletonizer(
    enabled: enabled,
    effect: _shimmer,
    textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(6)),
    child: child,
  );
}
