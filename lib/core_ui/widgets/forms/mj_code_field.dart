import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjCodeField extends StatefulWidget {
  const MjCodeField({
    required this.label,
    required this.length,
    required this.onChanged,
    this.initialValue = '',
    this.groupAfter = 2,
    this.autofocus = false,
    super.key,
  });

  final String label;
  final int length;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final int groupAfter;
  final bool autofocus;

  @override
  State<MjCodeField> createState() => _MjCodeFieldState();
}

class _MjCodeFieldState extends State<MjCodeField> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text(widget.label, textAlign: TextAlign.center, style: MjTextStyles.fieldLabel),
      const SizedBox(height: MjSpacing.small),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _focus.requestFocus,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                focusNode: _focus,
                autofocus: widget.autofocus,
                showCursor: false,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                  TextInputFormatter.withFunction(
                    (TextEditingValue _, TextEditingValue value) => value.copyWith(text: value.text.toUpperCase()),
                  ),
                  LengthLimitingTextInputFormatter(widget.length),
                ],
                onChanged: widget.onChanged,
              ),
            ),
            ListenableBuilder(
              listenable: Listenable.merge(<Listenable>[_controller, _focus]),
              builder: (BuildContext context, _) => Semantics(
                label: widget.label,
                value: _controller.text,
                textField: true,
                excludeSemantics: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6,
                  children: <Widget>[
                    for (int index = 0; index < widget.length; index++) ...<Widget>[
                      if (index == widget.groupAfter)
                        Text('-', style: MjTextStyles.stat.copyWith(color: MjColors.placeholder)),
                      MjCodeBox(
                        character: index < _controller.text.length ? _controller.text[index] : '',
                        active:
                            _focus.hasFocus &&
                            (index == _controller.text.length ||
                                (_controller.text.length == widget.length && index == widget.length - 1)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
