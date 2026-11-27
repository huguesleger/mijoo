import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

enum AccountLeaveChoice { leave }

class AccountLeaveSheet extends StatelessWidget {
  const AccountLeaveSheet({super.key});

  @override
  Widget build(BuildContext context) => MjBottomSheet(
    title: t.account.leaveTitle,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: MjSpacing.small,
        children: <Widget>[
          Text(t.account.leaveMessage, style: MjTextStyles.detail),
          const SizedBox(height: MjSpacing.small),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MjColors.error),
            onPressed: () => Navigator.of(context).pop(AccountLeaveChoice.leave),
            child: Text(t.account.leaveConfirm),
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(t.account.cancel)),
        ],
      ),
    ),
  );
}
