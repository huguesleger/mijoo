import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjAddField extends StatefulWidget {
  const MjAddField({required this.hint, required this.addLabel, required this.onAdd, super.key});

  final String hint;
  final String addLabel;
  final ValueChanged<String> onAdd;

  @override
  State<MjAddField> createState() => _MjAddFieldState();
}

class _MjAddFieldState extends State<MjAddField> {
  final TextEditingController _controller = TextEditingController();

  void _add() {
    final String text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onAdd(text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
    spacing: MjSpacing.small,
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: _controller,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _add(),
          decoration: InputDecoration(hintText: widget.hint, prefixIcon: const Icon(LucideIcons.plus)),
        ),
      ),
      MjStepButton(icon: LucideIcons.plus, tooltip: widget.addLabel, filled: true, onPressed: _add),
    ],
  );
}
