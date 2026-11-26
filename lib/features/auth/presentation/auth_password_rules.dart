import 'package:flutter/material.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_check_chip.dart';
import '../../../core_ui/ds_tokens.dart';
import '../domain/password_rule.dart';

class AuthPasswordRules extends StatelessWidget {
  const AuthPasswordRules({required this.password, super.key});

  final String password;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: DsSpacing.small),
    child: Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final rule in PasswordRule.values)
          DsCheckChip(
            label: switch (rule) {
              PasswordRule.minLength => t.auth.ruleMinLength,
              PasswordRule.digit => t.auth.ruleDigit,
              PasswordRule.uppercase => t.auth.ruleUppercase,
              PasswordRule.special => t.auth.ruleSpecial,
            },
            checked: rule.isMetBy(password),
          ),
      ],
    ),
  );
}
