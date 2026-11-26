import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core_ui/ds_hero_page.dart';
import 'welcome_content.dart';
import 'welcome_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => DsHeroPage(
    child: BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (_, state) => switch (state) {
        WelcomeReady() => const WelcomeContent(),
      },
    ),
  );
}
