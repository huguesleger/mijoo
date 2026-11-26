import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'ds_labeled_field.dart';

class DsPasswordField extends StatefulWidget {
  const DsPasswordField({
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
  State<DsPasswordField> createState() => _DsPasswordFieldState();
}

class _DsPasswordFieldState extends State<DsPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) => DsLabeledField(
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
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          tooltip: _obscured ? widget.showLabel : widget.hideLabel,
          icon: Icon(
            _obscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () => setState(() => _obscured = !_obscured),
        ),
      ),
    ),
  );
}
