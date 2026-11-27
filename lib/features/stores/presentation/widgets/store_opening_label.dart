import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/opening_status.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoreOpeningLabel extends StatelessWidget {
  const StoreOpeningLabel({required this.store, required this.now, super.key});

  final Store store;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final (String label, Color color) = storeOpeningStatus(store, now).match(
      () => (store.openingHours.isSome() ? t.stores.hoursOnSheet : t.stores.hoursUnknown, MjColors.placeholder),
      (OpeningStatus status) => (
        openingStatusLabel(status, now),
        switch (status) {
          StoreOpen() => MjColors.success,
          StoreClosed() => MjColors.peonyStrong,
        },
      ),
    );
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: MjTextStyles.detail.copyWith(color: color),
    );
  }
}
