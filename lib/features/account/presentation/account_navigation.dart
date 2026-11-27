import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/account/presentation/widgets/account_invite_sheet.dart';
import 'package:mijoo/features/account/presentation/widgets/account_leave_sheet.dart';

Future<void> openInviteSheet(BuildContext context) async {
  final HouseholdMembersCubit cubit = context.read<HouseholdMembersCubit>();
  final Future<void> invite = cubit.createInvite();
  await MjBottomSheet.show<void>(
    context,
    builder: (_) => BlocProvider<HouseholdMembersCubit>.value(value: cubit, child: const AccountInviteSheet()),
  );
  await invite;
}

Future<void> confirmLeave(BuildContext context) async {
  final HouseholdMembersCubit cubit = context.read<HouseholdMembersCubit>();
  final AccountLeaveChoice? choice = await MjBottomSheet.show<AccountLeaveChoice>(
    context,
    builder: (_) => const AccountLeaveSheet(),
  );
  await switch (choice) {
    AccountLeaveChoice.leave => cubit.leave(),
    null => Future<void>.value(),
  };
}
