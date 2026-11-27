import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';

class HomeScanCard extends StatelessWidget {
  const HomeScanCard({super.key});

  @override
  Widget build(BuildContext context) => MjGradientCard(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(t.home.scanTitle, style: MjTextStyles.cardTitle.copyWith(fontSize: 19)),
              const SizedBox(height: MjSpacing.extraSmall),
              Text(t.home.scanMessage, style: MjTextStyles.detail.copyWith(color: MjColors.ink)),
              const SizedBox(height: 14),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  textStyle: MjTextStyles.choice,
                ),
                onPressed: () => const ScanPageRoute(source: PhotoSource.camera).push<void>(context),
                icon: const Icon(LucideIcons.camera, size: 18),
                label: Text(t.home.scanAction),
              ),
            ],
          ),
        ),
        const SizedBox(width: MjSpacing.small),
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(color: MjColors.onInk.withValues(alpha: 0.45), shape: BoxShape.circle),
          child: const Icon(LucideIcons.refrigerator, size: 46, color: MjColors.ink),
        ),
      ],
    ),
  );
}
