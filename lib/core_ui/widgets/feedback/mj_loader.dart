import 'package:flutter/material.dart';

class MjLoader extends StatelessWidget {
  const MjLoader({super.key});

  static const minDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator.adaptive());
}
