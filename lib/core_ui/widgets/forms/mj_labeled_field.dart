import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjLabeledField extends StatelessWidget {
  const MjLabeledField({required this.label, required this.field, super.key});

  final String label;
  final Widget field;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: MjSpacing.extraSmall,
          bottom: MjSpacing.small,
        ),
        child: ExcludeSemantics(
          child: Text(label, style: MjTextStyles.fieldLabel),
        ),
      ),
      Semantics(label: label, child: field),
    ],
  );
}
