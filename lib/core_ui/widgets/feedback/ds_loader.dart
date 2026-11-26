import 'package:flutter/material.dart';

class DsLoader extends StatelessWidget {
  const DsLoader({super.key});

  static const minDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator.adaptive());
}
