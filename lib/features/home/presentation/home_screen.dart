import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';
import 'package:mijoo/core/presentation/widgets/tab_placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
    builder: (_, state) => TabPlaceholder(
      title: switch (state) {
        SignedIn(:final account) => account.name.match(
          () => t.shell.greeting,
          (name) => t.shell.greetingName(name: name),
        ),
        SessionUnknown() || SignedOut() => t.shell.greeting,
      },
    ),
  );
}
