import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ShoppingEmptyView extends StatelessWidget {
  const ShoppingEmptyView({super.key});

  @override
  Widget build(BuildContext context) => MjMessageView(
    title: some(t.shopping.emptyTitle),
    icon: some(LucideIcons.shoppingBasket),
    message: t.shopping.emptyMessage,
  );
}
