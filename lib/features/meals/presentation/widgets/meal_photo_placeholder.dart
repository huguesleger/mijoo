import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_kind_style.dart';

class MealPhotoPlaceholder extends StatelessWidget {
  const MealPhotoPlaceholder({required this.kind, super.key});

  final MealKind kind;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[MjColors.lavender, MjColors.peony],
      ),
    ),
    child: Center(child: Icon(mealKindIcon(kind), size: 56, color: MjColors.onInk)),
  );
}
