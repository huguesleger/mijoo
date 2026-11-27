import 'package:flutter/material.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/home/presentation/widgets/home_finish_first_card.dart';

class HomeFinishFirstRow extends StatelessWidget {
  const HomeFinishFirstRow({required this.items, required this.today, super.key});

  final List<FridgeItem> items;
  final DateTime today;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    clipBehavior: Clip.none,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: <Widget>[for (final FridgeItem item in items) HomeFinishFirstCard(item: item, today: today)],
    ),
  );
}
