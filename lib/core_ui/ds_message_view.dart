import 'package:flutter/material.dart';

import 'ds_card.dart';
import 'ds_tokens.dart';

class DsMessageView extends StatelessWidget {
  const DsMessageView({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) =>
      DsCard(child: Text(message, style: DsTextStyles.body));
}
