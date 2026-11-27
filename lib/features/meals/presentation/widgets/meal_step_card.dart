import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_step.dart';

class MealStepCard extends StatelessWidget {
  const MealStepCard({required this.number, required this.step, super.key});

  final int number;
  final MealStep step;

  @override
  Widget build(BuildContext context) => MjListCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                t.meals.stepNumber(number: number),
                style: MjTextStyles.cardTitle.copyWith(fontSize: 14, color: MjTone.lavender.foreground),
              ),
            ),
            ...step.minutes.match(
              () => const <Widget>[],
              (int minutes) => <Widget>[
                MjTag(
                  label: t.meals.minutes(count: minutes),
                  tone: MjTone.apricot,
                  icon: some(LucideIcons.timer),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          step.text,
          style: MjTextStyles.detail.copyWith(color: MjColors.ink, fontSize: 13.5, height: 20 / 13.5),
        ),
      ],
    ),
  );
}
