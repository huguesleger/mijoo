import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: navigationShell,
    bottomNavigationBar: MjNavigationBar(
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
