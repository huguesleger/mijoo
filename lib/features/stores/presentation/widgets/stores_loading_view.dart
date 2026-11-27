import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class StoresLoadingView extends StatelessWidget {
  const StoresLoadingView({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: MjSpacing.large),
    child: Column(
      children: <Widget>[
        const MjLoader(),
        const SizedBox(height: MjSpacing.medium),
        Text(t.stores.searching, textAlign: TextAlign.center, style: MjTextStyles.caption),
      ],
    ),
  );
}
