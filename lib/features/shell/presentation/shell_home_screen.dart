import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/i18n/translations.g.dart';
import '../../session/presentation/session_cubit.dart';
import 'shell_tab_screen.dart';

class ShellHomeScreen extends StatelessWidget {
  const ShellHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
    builder: (_, state) => ShellTabScreen(
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
