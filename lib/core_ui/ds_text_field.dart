import 'package:flutter/material.dart';

import 'ds_labeled_field.dart';

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

  @override
  Widget build(BuildContext context) => DsLabeledField(
    label: label,
    field: TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon)),
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      autocorrect: autocorrect,
      onChanged: onChanged,
    ),
  );
}
