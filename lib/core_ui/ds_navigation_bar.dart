import 'package:flutter/material.dart';

import 'ds_navigation_item.dart';
import 'ds_tokens.dart';

typedef DsNavigationDestination = ({IconData icon, String label});

class DsNavigationBar extends StatelessWidget {
  const DsNavigationBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<DsNavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    minimum: const EdgeInsets.only(bottom: DsSpacing.small),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.medium),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DsColors.surface,
          borderRadius: DsRadius.navigation,
          boxShadow: [
            BoxShadow(
              color: DsColors.lavenderStrong.withValues(alpha: 0.18),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(DsSpacing.small),
          child: Row(
            children: [
              for (final (index, destination) in destinations.indexed)
                Expanded(
                  child: DsNavigationItem(
                    icon: destination.icon,
                    label: destination.label,
                    selected: index == selectedIndex,
                    onTap: () => onSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
