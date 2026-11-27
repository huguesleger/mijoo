import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ScanFrame extends StatefulWidget {
  const ScanFrame({super.key});

  @override
  State<ScanFrame> createState() => _ScanFrameState();
}

class _ScanFrameState extends State<ScanFrame> with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(vsync: this, duration: const Duration(seconds: 2))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(34)),
      border: Border.all(color: MjColors.onInk.withValues(alpha: 0.9), width: 3),
    ),
    child: AnimatedBuilder(
      animation: _sweep,
      builder: (BuildContext context, Widget? line) =>
          Align(alignment: Alignment(0, _sweep.value * 1.8 - 0.9), child: line),
      child: Container(
        height: 3,
        margin: const EdgeInsets.symmetric(horizontal: MjSpacing.medium),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[Colors.transparent, MjColors.lavender, Colors.transparent],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(color: MjColors.lavender.withValues(alpha: 0.7), blurRadius: 18, spreadRadius: 4),
          ],
        ),
      ),
    ),
  );
}
