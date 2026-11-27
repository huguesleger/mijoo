import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_detail_content.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_detail_footer.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_missing_view.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_photo.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_failed_view.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<MealDetailCubit, MealDetailState>(
    listener: (BuildContext context, MealDetailState state) => switch (state) {
      MealDetailReady(cooking: MealCookingDone()) => context.pop(),
      MealDetailReady() || MealDetailLoading() || MealDetailFailed() || MealDetailMissing() => null,
    },
    builder: (BuildContext context, MealDetailState state) => switch (state) {
      final MealDetailReady ready => MjPhotoPage(
        photo: MealPhoto(idea: ready.idea),
        onBack: context.pop,
        badge: ready.idea.photo.map(
          (_) => MjTag(label: t.meals.photoBadge, tone: MjTone.neutral, icon: some(LucideIcons.image)),
        ),
        footer: some(MealDetailFooter(ready: ready)),
        child: MealDetailContent(ready: ready),
      ),
      MealDetailLoading() => const MjPage(
        child: Padding(padding: EdgeInsets.all(MjSpacing.extraLarge), child: MjLoader()),
      ),
      MealDetailMissing() => const MjPage(child: MealMissingView()),
      MealDetailFailed(:final failure) => MjPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: MjBackButton(onPressed: context.pop),
            ),
            MealsFailedView(
              failure: failure,
              onRetry: context.read<MealDetailCubit>().watch,
              placement: MjMessagePlacement.tab,
            ),
          ],
        ),
      ),
    },
  );
}
