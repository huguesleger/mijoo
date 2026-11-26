enum PasswordRule {
  minLength,
  digit,
  uppercase,
  special
  ;

  static const minimumLength = 8;

  bool isMetBy(String password) => switch (this) {
    PasswordRule.minLength => password.runes.length >= minimumLength,
    PasswordRule.digit => RegExp(r'\p{N}', unicode: true).hasMatch(password),
    PasswordRule.uppercase => RegExp(
      r'\p{Lu}',
      unicode: true,
    ).hasMatch(password),
    PasswordRule.special => RegExp(
      r'[^\p{L}\p{N}\s]',
      unicode: true,
    ).hasMatch(password),
  };

  static bool allMetBy(String password) => PasswordRule.values.every((rule) => rule.isMetBy(password));
}
