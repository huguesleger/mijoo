import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/account_button.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => MjPage(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MjTabHeader(title: title, actions: const <Widget>[AccountButton()]),
        const SizedBox(height: MjSpacing.large),
        MjMessageView(message: t.shell.comingSoon),
      ],
    ),
  );
}
