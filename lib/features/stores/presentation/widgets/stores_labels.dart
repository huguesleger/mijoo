import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/opening_status.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_filter.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/rules/opening_hours_rules.dart';

String storeKindLabel(StoreKind kind) => t.stores.kinds[kind.name] ?? kind.name;

String storeName(Store store) => store.name.getOrElse(() => storeKindLabel(store.kind));

String radiusLabel(StoreRadius radius) => t.stores.radius[radius.name] ?? '${radius.meters}';

double mapZoom(StoreRadius radius) => switch (radius) {
  StoreRadius.short => 15.5,
  StoreRadius.near => 14.5,
  StoreRadius.medium => 13.5,
  StoreRadius.far => 12.2,
};

String filterLabel(StoreFilter filter) => t.stores.filters[filter.name] ?? filter.name;

IconData storeKindIcon(StoreKind kind) => switch (kind) {
  StoreKind.supermarket => LucideIcons.shoppingCart,
  StoreKind.convenience => LucideIcons.store,
  StoreKind.bakery => LucideIcons.croissant,
  StoreKind.butcher => LucideIcons.beef,
  StoreKind.greengrocer => LucideIcons.carrot,
  StoreKind.organic => LucideIcons.leaf,
  StoreKind.cheese => LucideIcons.milk,
  StoreKind.frozenFood => LucideIcons.snowflake,
  StoreKind.marketplace => LucideIcons.apple,
};

MjTone storeKindTone(StoreKind kind) => switch (kind) {
  StoreKind.supermarket || StoreKind.greengrocer || StoreKind.organic || StoreKind.marketplace => MjTone.green,
  StoreKind.convenience => MjTone.apricot,
  StoreKind.bakery || StoreKind.butcher => MjTone.peony,
  StoreKind.cheese || StoreKind.frozenFood => MjTone.glacier,
};

Option<IconData> filterIcon(StoreFilter filter) => switch (filter) {
  StoreFilter.all => none(),
  StoreFilter.supermarkets => some(LucideIcons.shoppingCart),
  StoreFilter.local => some(LucideIcons.store),
  StoreFilter.bakeries => some(LucideIcons.croissant),
  StoreFilter.markets => some(LucideIcons.apple),
  StoreFilter.specialists => some(LucideIcons.beef),
};

String distanceLabel(int meters) => meters < 1000
    ? t.stores.meters(meters: (meters / 10).round() * 10)
    : t.stores.kilometers(kilometers: (meters / 1000).toStringAsFixed(1).replaceAll('.', ','));

String timeLabel(int minute) =>
    t.stores.time(hours: (minute ~/ 60) % 24, minutes: (minute % 60).toString().padLeft(2, '0'));

String countLabel(int count, StoreRadius radius) => switch (count) {
  0 => t.stores.countZero(radius: radiusLabel(radius)),
  1 => t.stores.countSingle(radius: radiusLabel(radius)),
  _ => t.stores.countSeveral(count: count, radius: radiusLabel(radius)),
};

String openingStatusLabel(OpeningStatus status, DateTime now) => switch (status) {
  StoreOpen(:final Option<int> closesAt) => closesAt.match(
    () => t.stores.open,
    (int minute) => t.stores.openUntil(time: timeLabel(minute)),
  ),
  StoreClosed(:final Option<StoreMoment> opensAt) => opensAt.match(
    () => t.stores.closed,
    (StoreMoment moment) => moment.weekday == now.weekday
        ? t.stores.closedOpensToday(time: timeLabel(moment.minute))
        : t.stores.closedOpensOn(day: t.stores.days[moment.weekday - 1], time: timeLabel(moment.minute)),
  ),
};

Option<OpeningStatus> storeOpeningStatus(Store store, DateTime now) =>
    store.openingHours.flatMap(parseOpeningHours).map((hours) => openingStatus(hours, now));
