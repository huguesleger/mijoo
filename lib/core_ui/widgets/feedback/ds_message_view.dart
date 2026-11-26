import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsMessageView extends StatelessWidget {
  const DsMessageView({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) => DsCard(child: Text(message, style: DsTextStyles.body));
}
