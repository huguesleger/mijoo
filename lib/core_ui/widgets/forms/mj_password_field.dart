import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class MjPasswordField extends StatefulWidget {
  const MjPasswordField({
    required this.label,
    required this.hint,
    required this.showLabel,
    required this.hideLabel,
    required this.initialValue,
    required this.autofillHints,
    required this.onChanged,
    this.error = const None(),
    super.key,
  });

  final String label;
  final String hint;
  final String showLabel;
  final String hideLabel;
  final String initialValue;
  final List<String> autofillHints;
  final ValueChanged<String> onChanged;
  final Option<String> error;

  @override
  State<MjPasswordField> createState() => _DsPasswordFieldState();
}

class _DsPasswordFieldState extends State<MjPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) => MjLabeledField(
    label: widget.label,
    field: TextFormField(
      initialValue: widget.initialValue,
      obscureText: _obscured,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: widget.autofillHints,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        errorText: widget.error.toNullable(),
        prefixIcon: const Icon(LucideIcons.lockKeyhole),
        suffixIcon: IconButton(
          tooltip: _obscured ? widget.showLabel : widget.hideLabel,
          icon: Icon(_obscured ? LucideIcons.eye : LucideIcons.eyeOff),
          onPressed: () => setState(() => _obscured = !_obscured),
        ),
      ),
    ),
  );
}
