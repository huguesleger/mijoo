import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/shopping_navigation.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_labels.dart';

class ShoppingLineTile extends StatelessWidget {
  const ShoppingLineTile({required this.line, super.key});

  final ShoppingLine line;

  @override
  Widget build(BuildContext context) {
    final Color text = line.checked ? MjColors.placeholder : MjColors.ink;
    return MjListCard(
      onTap: () => openShoppingLineSheet(context, line),
      child: Row(
        children: <Widget>[
          Semantics(
            button: true,
            checked: line.checked,
            label: line.checked ? t.shopping.uncheck(name: line.name) : t.shopping.check(name: line.name),
            excludeSemantics: true,
            child: InkWell(
              onTap: () => context.read<ShoppingCubit>().toggle(line),
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: MjCheckCircle(checked: line.checked),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  line.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MjTextStyles.itemTitle.copyWith(
                    color: text,
                    decoration: line.checked ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  line.manual
                      ? line.addedBy.match(() => t.shopping.manual, (String name) => t.shopping.addedBy(name: name))
                      : line.meals.join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MjTextStyles.detail.copyWith(fontSize: 11.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: MjSpacing.small),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                shoppingQuantityLabel(line, line.purchase),
                style: MjTextStyles.cardTitle.copyWith(fontSize: 14.5, color: text),
              ),
              ...shoppingNeededLabel(line).match(
                () => const <Widget>[],
                (String needed) => <Widget>[
                  Text(needed, style: MjTextStyles.detail.copyWith(fontSize: 10.5, color: MjColors.placeholder)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
