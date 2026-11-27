import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/account_button.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
    builder: (_, SessionState state) {
      final String name = switch (state) {
        SignedIn(:final account) => account.name.getOrElse(() => ''),
        SessionUnknown() || SignedOut() => '',
      };
      return Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: MjColors.peony, shape: BoxShape.circle),
            child: Text(
              name.isEmpty ? '' : name.characters.first.toUpperCase(),
              style: MjTextStyles.cardTitle,
            ),
          ),
          const SizedBox(width: MjSpacing.fieldGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.home.hello, style: MjTextStyles.detail),
                Text(name.isEmpty ? t.shell.greeting : name, style: MjTextStyles.cardTitle),
              ],
            ),
          ),
          const AccountButton(),
        ],
      );
    },
  );
}
