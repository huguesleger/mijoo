import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

typedef MjNavigationDestination = ({IconData icon, String label});

class MjNavigationBar extends StatelessWidget {
  const MjNavigationBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<MjNavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    minimum: const EdgeInsets.only(bottom: MjSpacing.small),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MjSpacing.medium),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MjColors.surface,
          borderRadius: MjRadius.navigation,
          boxShadow: [
            BoxShadow(
              color: MjColors.lavenderStrong.withValues(alpha: 0.18),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(MjSpacing.small),
          child: Row(
            children: [
              for (final (index, destination) in destinations.indexed)
                Expanded(
                  child: MjNavigationItem(
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
