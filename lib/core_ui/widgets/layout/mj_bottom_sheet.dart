import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MjBottomSheet extends StatelessWidget {
  const MjBottomSheet({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) => showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: MjColors.surface,
    shape: const RoundedRectangleBorder(borderRadius: MjRadius.sheet),
    builder: builder,
  );

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
    child: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(MjSpacing.large, 0, MjSpacing.large, MjSpacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Semantics(header: true, child: Text(title, style: MjTextStyles.sheetTitle)),
              const SizedBox(height: MjSpacing.large),
              Flexible(child: child),
            ],
          ),
        ),
      ),
    ),
  );
}
