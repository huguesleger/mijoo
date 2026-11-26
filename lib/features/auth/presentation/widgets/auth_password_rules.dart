import 'package:flutter/material.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/domain/rules/password_rule.dart';

class AuthPasswordRules extends StatelessWidget {
  const AuthPasswordRules({required this.password, super.key});

  final String password;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: MjSpacing.small),
    child: Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final rule in PasswordRule.values)
          MjCheckChip(
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
