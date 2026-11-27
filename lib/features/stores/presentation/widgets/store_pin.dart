import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StorePin extends StatelessWidget {
  const StorePin({required this.kind, required this.label, required this.onTap, super.key});

  static const double size = 26;

  final StoreKind kind;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    excludeSemantics: true,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: storeKindTone(kind).foreground,
          shape: BoxShape.circle,
          border: Border.all(color: MjColors.onInk, width: 2),
        ),
        child: Icon(storeKindIcon(kind), size: 13, color: MjColors.onInk),
      ),
    ),
  );
}
