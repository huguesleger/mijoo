import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/domain/rules/stores_rules.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';
import 'package:mijoo/features/stores/presentation/stores_navigation.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_tile.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_map.dart';

class StoresLoadedView extends StatelessWidget {
  const StoresLoadedView({required this.state, super.key});

  final StoresLoaded state;

  @override
  Widget build(BuildContext context) {
    final List<NearbyStore> stores = nearbyStores(
      state.stores,
      state.center,
      state.choices.radius,
      state.choices.filter,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ...switch (state.choices.view) {
          StoresView.map => <Widget>[
            StoresMap(
              center: state.center,
              radius: state.choices.radius,
              stores: stores,
              onStore: (NearbyStore nearby) => openStoreSheet(context, nearby, state.now),
            ),
            const SizedBox(height: MjSpacing.large),
          ],
          StoresView.list => const <Widget>[],
        },
        MjSectionTitle(title: countLabel(stores.length, state.choices.radius)),
        const SizedBox(height: MjSpacing.fieldGap),
        if (stores.isEmpty)
          MjMessageView(message: t.stores.emptyFilter)
        else
          for (final NearbyStore nearby in stores)
            Padding(
              padding: const EdgeInsets.only(bottom: MjSpacing.small),
              child: StoreTile(
                nearby: nearby,
                now: state.now,
                onTap: () => openStoreSheet(context, nearby, state.now),
              ),
            ),
        const SizedBox(height: MjSpacing.small),
        Text(t.stores.attribution, textAlign: TextAlign.center, style: MjTextStyles.caption),
      ],
    );
  }
}
