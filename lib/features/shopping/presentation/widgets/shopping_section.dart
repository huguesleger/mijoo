import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/shopping/domain/entities/line_cost.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_entry.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_line.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_line_tile.dart';

class ShoppingSection extends StatelessWidget {
  const ShoppingSection({
    required this.title,
    required this.icon,
    required this.tone,
    required this.lines,
    required this.costs,
    required this.today,
    required this.trailing,
    super.key,
  });

  final String title;
  final IconData icon;
  final MjTone tone;
  final List<ShoppingLine> lines;
  final Map<ShoppingEntryId, LineCost> costs;
  final DateTime today;
  final String trailing;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: 7,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: MjSpacing.small),
        child: Row(
          spacing: MjSpacing.small,
          children: <Widget>[
            MjIconTile(icon: icon, tone: tone, size: 30),
            Expanded(
              child: MjSectionTitle(
                title: title,
                trailing: some(Text(trailing, style: MjTextStyles.detail)),
              ),
            ),
          ],
        ),
      ),
      for (final ShoppingLine line in lines)
        ShoppingLineTile(line: line, cost: Option<LineCost>.fromNullable(costs[line.id]), today: today),
    ],
  );
}
