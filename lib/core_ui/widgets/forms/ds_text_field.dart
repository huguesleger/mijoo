import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;

import 'package:mijoo/core_ui/core_ui.dart';

class DsTextField extends StatelessWidget {
  const DsTextField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType,
    this.autofillHints = const [],
    this.autocorrect = true,
    this.suffixText = const None(),
    this.error = const None(),
    super.key,
  });

  final String label;
  final String hint;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final List<String> autofillHints;
  final bool autocorrect;
  final Option<String> suffixText;
  final Option<String> error;

  @override
  Widget build(BuildContext context) => DsLabeledField(
    label: label,
    field: TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixText: suffixText.toNullable(),
        errorText: error.toNullable(),
      ),
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      autocorrect: autocorrect,
      onChanged: onChanged,
    ),
  );
}
