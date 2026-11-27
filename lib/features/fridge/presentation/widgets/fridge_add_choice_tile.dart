import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice.dart';

class FridgeAddChoiceTile extends StatelessWidget {
  const FridgeAddChoiceTile({
    required this.choice,
    required this.icon,
    required this.tone,
    required this.title,
    required this.detail,
    super.key,
  });

  final FridgeAddChoice choice;
  final IconData icon;
  final MjTone tone;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    child: InkWell(
      onTap: () => Navigator.of(context).pop<FridgeAddChoice>(choice),
      borderRadius: MjRadius.card,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: tone.surface, borderRadius: const BorderRadius.all(Radius.circular(22))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(color: MjColors.onInk, shape: BoxShape.circle),
              child: Icon(icon, size: 20, color: tone.foreground),
            ),
            const SizedBox(height: MjSpacing.fieldGap),
            Text(title, style: MjTextStyles.cardTitle.copyWith(fontSize: 15)),
            const SizedBox(height: 2),
            Text(detail, style: MjTextStyles.detail.copyWith(fontSize: 11.5, height: 15 / 11.5)),
          ],
        ),
      ),
    ),
  );
}
