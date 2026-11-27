import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice.dart';

class FridgeAddChoiceHero extends StatelessWidget {
  const FridgeAddChoiceHero({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    child: InkWell(
      onTap: () => Navigator.of(context).pop<FridgeAddChoice>(FridgeAddChoice.fridgePhoto),
      borderRadius: MjRadius.card,
      child: MjGradientCard(
        child: Row(
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(color: MjColors.onInk, shape: BoxShape.circle),
              child: const Icon(LucideIcons.camera, size: 26, color: MjColors.ink),
            ),
            const SizedBox(width: MjSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(t.fridge.addPhoto, style: MjTextStyles.cardTitle),
                  const SizedBox(height: MjSpacing.extraSmall),
                  Text(t.fridge.addPhotoDetail, style: MjTextStyles.detail.copyWith(color: MjColors.ink)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: MjColors.ink),
          ],
        ),
      ),
    ),
  );
}
