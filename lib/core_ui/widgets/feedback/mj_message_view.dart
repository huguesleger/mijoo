import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show None, Option;
import 'package:mijoo/core_ui/core_ui.dart';

class MjMessageView extends StatelessWidget {
  const MjMessageView({
    required this.message,
    this.title = const None(),
    this.icon = const None(),
    this.action = const None(),
    this.placement = MjMessagePlacement.card,
    super.key,
  });

  final String message;
  final Option<String> title;
  final Option<IconData> icon;
  final Option<MjMessageAction> action;
  final MjMessagePlacement placement;

  @override
  Widget build(BuildContext context) {
    final TextAlign align = switch (placement) {
      MjMessagePlacement.card => TextAlign.start,
      MjMessagePlacement.tab => TextAlign.center,
    };
    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ...icon.match(
          () => const <Widget>[],
          (IconData icon) => <Widget>[MjIconBadge(icon: icon), const SizedBox(height: MjSpacing.large)],
        ),
        ...title.match(
          () => const <Widget>[],
          (String title) => <Widget>[
            Text(title, textAlign: align, style: MjTextStyles.sectionTitle),
            const SizedBox(height: MjSpacing.small),
          ],
        ),
        Text(message, textAlign: align, style: MjTextStyles.body),
        ...action.match(
          () => const <Widget>[],
          (MjMessageAction action) => <Widget>[
            const SizedBox(height: MjSpacing.large),
            FilledButton(onPressed: action.onPressed, child: Text(action.label)),
          ],
        ),
      ],
    );
    return switch (placement) {
      MjMessagePlacement.card => MjCard(child: content),
      MjMessagePlacement.tab => Padding(
        padding: const EdgeInsets.symmetric(vertical: MjSpacing.extraLarge, horizontal: MjSpacing.small),
        child: content,
      ),
    };
  }
}
