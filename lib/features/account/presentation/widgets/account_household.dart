import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/widgets/account_household_tiles.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';

class AccountHousehold extends StatelessWidget {
  const AccountHousehold({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
    builder: (_, SessionState state) => switch (state) {
      SignedIn(household: HouseholdFound(:final household)) => household.profile.match(
        () => const SizedBox.shrink(),
        (HouseholdProfile profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MjSectionTitle(title: t.account.household),
            const SizedBox(height: MjSpacing.fieldGap),
            AccountHouseholdTiles(profile: profile),
          ],
        ),
      ),
      SignedIn() || SessionUnknown() || SignedOut() => const SizedBox.shrink(),
    },
  );
}
