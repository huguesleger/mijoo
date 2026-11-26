import 'package:flutter/widgets.dart';

class MjMessageAction {
  const MjMessageAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}
