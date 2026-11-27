import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' show some;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/household/domain/rules/invite_codes.dart';
import 'package:share_plus/share_plus.dart';

class AccountInviteSheet extends StatefulWidget {
  const AccountInviteSheet({super.key});

  @override
  State<AccountInviteSheet> createState() => _AccountInviteSheetState();
}

class _AccountInviteSheetState extends State<AccountInviteSheet> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: t.account.inviteTitle,
    child: SingleChildScrollView(
      child: BlocBuilder<HouseholdMembersCubit, HouseholdMembersState>(
        builder: (BuildContext context, HouseholdMembersState state) => switch (state) {
          MembersLoaded(invite: InviteReady(:final code)) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: MjSpacing.fieldGap,
            children: <Widget>[
              Text(t.account.inviteMessage, style: MjTextStyles.detail),
              MjCodeDisplay(
                code: displayInviteCode(code),
                label: t.account.inviteCodeLabel(code: code.value.split('').join(' ')),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: MjSpacing.small,
                children: <Widget>[
                  MjTag(label: t.account.inviteValid, tone: MjTone.apricot, icon: some(LucideIcons.timer)),
                  MjTag(label: t.account.inviteOnce, tone: MjTone.lavender, icon: some(LucideIcons.keyRound)),
                ],
              ),
              FilledButton.icon(
                onPressed: () => SharePlus.instance.share(
                  ShareParams(text: t.account.shareText(code: displayInviteCode(code))),
                ),
                icon: const Icon(LucideIcons.share2),
                label: Text(t.account.share),
              ),
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: displayInviteCode(code)));
                  if (mounted) setState(() => _copied = true);
                },
                icon: Icon(_copied ? LucideIcons.check : LucideIcons.copy, size: 18),
                label: Text(_copied ? t.account.copied : t.account.copy),
              ),
              MjMessageView(icon: some(LucideIcons.shieldCheck), message: t.account.inviteNote),
            ],
          ),
          MembersLoaded(invite: InviteFailed(:final failure)) => FailureView(failure: failure),
          MembersLoaded(invite: InviteIdle() || InviteCreating()) ||
          MembersLoading() ||
          MembersFailed() => const Padding(padding: EdgeInsets.all(MjSpacing.extraLarge), child: MjLoader()),
        },
      ),
    ),
  );
}
