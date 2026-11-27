import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjQuantityStepper extends StatefulWidget {
  const MjQuantityStepper({
    required this.label,
    required this.value,
    required this.decreaseLabel,
    required this.increaseLabel,
    required this.onChanged,
    required this.onDecrease,
    required this.onIncrease,
    this.error = const None(),
    super.key,
  });

  final String label;
  final String value;
  final String decreaseLabel;
  final String increaseLabel;
  final ValueChanged<String> onChanged;
  final VoidCallback? onDecrease;
  final VoidCallback onIncrease;
  final Option<String> error;

  @override
  State<MjQuantityStepper> createState() => _MjQuantityStepperState();
}

class _MjQuantityStepperState extends State<MjQuantityStepper> {
  late final TextEditingController _controller = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(MjQuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) _controller.text = widget.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MjLabeledField(
    label: widget.label,
    field: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: MjSpacing.fieldGap,
      children: <Widget>[
        MjStepButton(icon: LucideIcons.minus, tooltip: widget.decreaseLabel, onPressed: widget.onDecrease),
        Expanded(
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: MjTextStyles.stat,
            decoration: InputDecoration(
              errorText: widget.error.toNullable(),
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
            ),
            onChanged: widget.onChanged,
          ),
        ),
        MjStepButton(
          icon: LucideIcons.plus,
          tooltip: widget.increaseLabel,
          filled: true,
          onPressed: widget.onIncrease,
        ),
      ],
    ),
  );
}
