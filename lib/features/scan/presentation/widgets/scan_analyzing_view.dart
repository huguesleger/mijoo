import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/scan/presentation/widgets/scan_frame.dart';

class ScanAnalyzingView extends StatelessWidget {
  const ScanAnalyzingView({required this.photo, super.key});

  final Uint8List photo;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MjColors.ink,
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.memory(
          photo,
          fit: BoxFit.cover,
          color: MjColors.ink.withValues(alpha: 0.35),
          colorBlendMode: BlendMode.darken,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(MjSpacing.pageGutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: MjRoundIconButton(icon: LucideIcons.x, tooltip: t.scan.cancel, onPressed: context.pop),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MjSpacing.small, vertical: MjSpacing.large),
                    child: ScanFrame(),
                  ),
                ),
                Semantics(
                  liveRegion: true,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(22, MjSpacing.large, 22, 26),
                    decoration: const BoxDecoration(color: MjColors.surface, borderRadius: MjRadius.card),
                    child: Column(
                      children: <Widget>[
                        const MjIconTile(icon: LucideIcons.sparkles, tone: MjTone.lavender, size: 56),
                        const SizedBox(height: MjSpacing.fieldGap),
                        Text(t.scan.analyzingTitle, textAlign: TextAlign.center, style: MjTextStyles.sheetTitle),
                        const SizedBox(height: 6),
                        Text(t.scan.analyzingMessage, textAlign: TextAlign.center, style: MjTextStyles.detail),
                        const SizedBox(height: MjSpacing.medium),
                        const ClipRRect(
                          borderRadius: MjRadius.pill,
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            backgroundColor: MjColors.field,
                            color: MjColors.lavenderStrong,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
