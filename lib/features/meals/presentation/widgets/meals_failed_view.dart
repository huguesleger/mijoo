import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/failure_message.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MealsFailedView extends StatelessWidget {
  const MealsFailedView({required this.failure, required this.onRetry, required this.placement, super.key});

  final AppFailure failure;
  final VoidCallback onRetry;
  final MjMessagePlacement placement;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: MjMessageView(
      message: failureMessage(failure),
      icon: some(LucideIcons.cloudAlert),
      action: some(MjMessageAction(label: t.meals.retry, onPressed: onRetry)),
      placement: placement,
    ),
  );
}
