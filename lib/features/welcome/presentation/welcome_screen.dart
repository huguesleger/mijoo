import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/welcome/presentation/widgets/welcome_content.dart';
import 'package:mijoo/features/welcome/presentation/bloc/welcome_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => MjHeroPage(
    child: BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (_, state) => switch (state) {
        WelcomeReady() => const WelcomeContent(),
      },
    ),
  );
}
