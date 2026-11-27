import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/home/presentation/widgets/home_finish_first.dart';
import 'package:mijoo/features/home/presentation/widgets/home_greeting.dart';
import 'package:mijoo/features/home/presentation/widgets/home_meal_teaser.dart';
import 'package:mijoo/features/home/presentation/widgets/home_scan_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => MjPage(
    child: Padding(
      padding: const EdgeInsets.only(bottom: MjSpacing.navigationClearance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HomeGreeting(),
          const SizedBox(height: MjSpacing.large),
          Semantics(
            header: true,
            child: Text.rich(
              TextSpan(
                text: t.home.titleLead,
                children: <TextSpan>[
                  TextSpan(
                    text: t.home.titleHighlight,
                    style: const TextStyle(color: MjColors.primary),
                  ),
                ],
              ),
              style: MjTextStyles.headline.copyWith(fontSize: 30),
            ),
          ),
          const SizedBox(height: MjSpacing.medium),
          const HomeScanCard(),
          const SizedBox(height: MjSpacing.large),
          MjSectionTitle(
            title: t.home.finishFirst,
            trailing: some(
              TextButton(
                style: TextButton.styleFrom(minimumSize: const Size(0, 36)),
                onPressed: () => const FridgePageRoute().go(context),
                child: Text(t.home.seeAll, style: MjTextStyles.detail.copyWith(color: MjColors.primary)),
              ),
            ),
          ),
          const SizedBox(height: MjSpacing.small),
          const HomeFinishFirst(),
          const SizedBox(height: MjSpacing.large),
          MjSectionTitle(title: t.home.mealIdea),
          const SizedBox(height: MjSpacing.fieldGap),
          const HomeMealTeaser(),
        ],
      ),
    ),
  );
}
