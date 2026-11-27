import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class HomeMealTeaser extends StatelessWidget {
  const HomeMealTeaser({super.key});

  @override
  Widget build(BuildContext context) => MjListCard(
    onTap: () => const MealsPageRoute().go(context),
    child: Row(
      children: <Widget>[
        Assets.images.bolBleu.image(width: 92, height: 92, fit: BoxFit.contain, excludeFromSemantics: true),
        const SizedBox(width: MjSpacing.fieldGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(t.home.mealSoonTitle, style: MjTextStyles.cardTitle.copyWith(fontSize: 17)),
              const SizedBox(height: 6),
              Text(t.home.mealSoonMessage, style: MjTextStyles.detail),
            ],
          ),
        ),
        const Icon(LucideIcons.chevronRight, color: MjColors.placeholder),
      ],
    ),
  );
}
