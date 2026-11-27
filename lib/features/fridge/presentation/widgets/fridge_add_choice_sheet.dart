import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice_hero.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice_tile.dart';

class FridgeAddChoiceSheet extends StatelessWidget {
  const FridgeAddChoiceSheet({super.key});

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: t.fridge.addChoiceTitle,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const FridgeAddChoiceHero(),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: <Widget>[
                Expanded(
                  child: FridgeAddChoiceTile(
                    choice: FridgeAddChoice.galleryPhoto,
                    icon: LucideIcons.images,
                    tone: MjTone.peony,
                    title: t.fridge.addGallery,
                    detail: t.fridge.addGalleryDetail,
                  ),
                ),
                Expanded(
                  child: FridgeAddChoiceTile(
                    choice: FridgeAddChoice.barcode,
                    icon: LucideIcons.scanBarcode,
                    tone: MjTone.apricot,
                    title: t.fridge.addBarcode,
                    detail: t.fridge.addBarcodeDetail,
                  ),
                ),
                Expanded(
                  child: FridgeAddChoiceTile(
                    choice: FridgeAddChoice.manual,
                    icon: LucideIcons.pencil,
                    tone: MjTone.neutral,
                    title: t.fridge.addManual,
                    detail: t.fridge.addManualDetail,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: MjSpacing.medium),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: MjSpacing.fieldGap),
            decoration: const BoxDecoration(color: MjColors.field, borderRadius: MjRadius.input),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(LucideIcons.shieldCheck, size: 18, color: MjColors.success),
                const SizedBox(width: 10),
                Expanded(child: Text(t.fridge.photoPrivacy, style: MjTextStyles.detail.copyWith(fontSize: 12))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
