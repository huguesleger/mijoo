import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class DsLabeledField extends StatelessWidget {
  const DsLabeledField({required this.label, required this.field, super.key});

  final String label;
  final Widget field;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: DsSpacing.extraSmall,
          bottom: DsSpacing.small,
        ),
        child: ExcludeSemantics(
          child: Text(label, style: DsTextStyles.fieldLabel),
        ),
      ),
      Semantics(label: label, child: field),
    ],
  );
}
