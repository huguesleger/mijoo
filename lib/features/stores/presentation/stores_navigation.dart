import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_sheet.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_sheet_choice.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_position_choice.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_position_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> askStoresPosition(BuildContext context) async {
  final StoresCubit cubit = context.read<StoresCubit>();
  final StoresPositionChoice? choice = await MjBottomSheet.show<StoresPositionChoice>(
    context,
    builder: (_) => StoresPositionSheet(town: cubit.state.town),
  );
  await switch (choice) {
    StoresPositionChoice.usePosition => cubit.usePosition(),
    StoresPositionChoice.stay || null => Future<void>.value(),
  };
}

Future<void> openStoreSheet(BuildContext context, NearbyStore nearby, DateTime now) async {
  final StoreSheetChoice? choice = await MjBottomSheet.show<StoreSheetChoice>(
    context,
    builder: (_) => StoreSheet(nearby: nearby, now: now),
  );
  await switch (choice) {
    StoreSheetChoice.directions => launchUrl(directionsUri(nearby.store), mode: LaunchMode.externalApplication),
    null => Future<bool>.value(false),
  };
}

Uri directionsUri(Store store) {
  final String destination = '${store.coordinates.latitude},${store.coordinates.longitude}';
  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => Uri.https('maps.apple.com', '/', <String, String>{
      'daddr': destination,
      'q': store.name.getOrElse(() => destination),
    }),
    TargetPlatform.android || TargetPlatform.fuchsia || TargetPlatform.linux || TargetPlatform.windows => Uri.https(
      'www.google.com',
      '/maps/dir/',
      <String, String>{
        'api': '1',
        'destination': destination,
      },
    ),
  };
}
