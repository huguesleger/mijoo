import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class HouseholdEditHeader extends StatelessWidget {
  const HouseholdEditHeader({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      MjBackButton(onPressed: context.pop),
      Expanded(
        child: Semantics(
          header: true,
          child: Text(t.setup.editTitle, textAlign: TextAlign.center, style: MjTextStyles.cardTitle),
        ),
      ),
      const SizedBox(width: MjSpacing.tapTarget),
    ],
  );
}
