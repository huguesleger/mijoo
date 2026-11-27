import 'package:flutter/material.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_photo_placeholder.dart';

class MealPhoto extends StatelessWidget {
  const MealPhoto({required this.idea, super.key});

  final MealIdea idea;

  @override
  Widget build(BuildContext context) => idea.photo.match(
    () => MealPhotoPlaceholder(kind: idea.kind),
    (Uri photo) => Image.network(
      photo.toString(),
      fit: BoxFit.cover,
      excludeFromSemantics: true,
      frameBuilder: (_, Widget child, int? frame, bool loadedAtOnce) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MealPhotoPlaceholder(kind: idea.kind),
          AnimatedOpacity(
            opacity: frame == null && !loadedAtOnce ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: child,
          ),
        ],
      ),
      errorBuilder: (_, Object error, StackTrace? stack) => MealPhotoPlaceholder(kind: idea.kind),
    ),
  );
}
