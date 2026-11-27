import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/widgets/account_household_tile.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

class AccountHouseholdTiles extends StatelessWidget {
  const AccountHouseholdTiles({required this.profile, super.key});

  final HouseholdProfile profile;

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1.25,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: <Widget>[
      AccountHouseholdTile(
        icon: LucideIcons.users,
        tone: MjTone.lavender,
        value: profile.people == 1 ? t.account.peopleSingle : t.account.peopleSeveral(count: profile.people),
        detail: t.account.composition(
          adults: profile.adults == 1 ? t.account.adultsSingle : t.account.adultsSeveral(count: profile.adults),
          children: switch (profile.children) {
            0 => t.account.childrenZero,
            1 => t.account.childrenSingle,
            final int count => t.account.childrenSeveral(count: count),
          },
        ),
      ),
      AccountHouseholdTile(
        icon: LucideIcons.clock3,
        tone: MjTone.apricot,
        value: t.account.minutes(count: profile.maxPrepMinutes),
        detail: t.account.prepDetail,
      ),
      AccountHouseholdTile(
        icon: LucideIcons.wallet,
        tone: MjTone.green,
        value: profile.weeklyBudgetCents.match(
          () => t.account.noBudget,
          (int cents) => NumberFormat.currency(locale: 'fr', symbol: '€', decimalDigits: 0).format(cents / 100),
        ),
        detail: t.account.budgetDetail,
      ),
      AccountHouseholdTile(
        icon: LucideIcons.shieldAlert,
        tone: MjTone.peony,
        value: switch (profile.allergies.length) {
          0 => t.account.allergiesZero,
          1 => t.account.allergiesSingle,
          final int count => t.account.allergiesSeveral(count: count),
        },
        detail: profile.location.match(
          () => t.account.noLocation,
          (HouseholdLocation location) => '${location.city} · ${location.postalCode}',
        ),
      ),
    ],
  );
}
