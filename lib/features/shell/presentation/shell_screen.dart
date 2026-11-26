import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_navigation_bar.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: navigationShell,
    bottomNavigationBar: DsNavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      destinations: [
        (icon: LucideIcons.house, label: t.shell.home),
        (icon: LucideIcons.refrigerator, label: t.shell.fridge),
        (icon: LucideIcons.chefHat, label: t.shell.meals),
        (icon: LucideIcons.shoppingCart, label: t.shell.shopping),
      ],
    ),
  );
}
