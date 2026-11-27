import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class MjNavigationItem extends StatelessWidget {
  const MjNavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: label,
    excludeSemantics: true,
    child: InkWell(
      onTap: onTap,
      borderRadius: MjRadius.pill,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        height: 52,
        constraints: const BoxConstraints(minWidth: 52),
        padding: EdgeInsets.symmetric(horizontal: selected ? 18 : 0),
        decoration: BoxDecoration(
          color: selected ? MjColors.ink : Colors.transparent,
          borderRadius: MjRadius.pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 22, color: selected ? MjColors.onInk : MjColors.secondaryText),
            if (selected) ...<Widget>[
              const SizedBox(width: MjSpacing.small),
              Text(
                label,
                maxLines: 1,
                style: MjTextStyles.navigation.copyWith(
                  color: MjColors.onInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
