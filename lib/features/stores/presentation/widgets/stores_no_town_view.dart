import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/presentation/stores_navigation.dart';

class StoresNoTownView extends StatelessWidget {
  const StoresNoTownView({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      MjMessageView(
        placement: MjMessagePlacement.tab,
        icon: some(LucideIcons.mapPinned),
        title: some(t.stores.noTownTitle),
        message: t.stores.noTownMessage,
        action: some(MjMessageAction(label: t.stores.usePosition, onPressed: () => askStoresPosition(context))),
      ),
      TextButton(
        onPressed: () => const HouseholdEditPageRoute().push<void>(context),
        child: Text(t.stores.noTownEdit),
      ),
    ],
  );
}
