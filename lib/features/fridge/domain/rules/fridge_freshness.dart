import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';

enum FridgeFreshness { expired, urgent, soon, fresh }

typedef FridgeFreshnessSummary = ({int total, int toFinish, int expired});

const int urgentDays = 1;
const int soonDays = 3;

Option<int> daysLeft(FridgeItem item, DateTime today) => item.bestBefore.map(
  (DateTime date) =>
      DateTime.utc(date.year, date.month, date.day).difference(DateTime.utc(today.year, today.month, today.day)).inDays,
);

FridgeFreshness fridgeFreshness(FridgeItem item, DateTime today) => daysLeft(item, today).match(
  () => FridgeFreshness.fresh,
  (int days) => days < 0
      ? FridgeFreshness.expired
      : days <= urgentDays
      ? FridgeFreshness.urgent
      : days <= soonDays
      ? FridgeFreshness.soon
      : FridgeFreshness.fresh,
);

FridgeFreshnessSummary fridgeFreshnessSummary(List<FridgeItem> items, DateTime today) {
  final List<FridgeFreshness> freshness = <FridgeFreshness>[
    for (final FridgeItem item in items) fridgeFreshness(item, today),
  ];
  return (
    total: items.length,
    toFinish: freshness
        .where((FridgeFreshness value) => value == FridgeFreshness.urgent || value == FridgeFreshness.soon)
        .length,
    expired: freshness.where((FridgeFreshness value) => value == FridgeFreshness.expired).length,
  );
}

List<FridgeItem> itemsToFinishFirst(List<FridgeItem> items, DateTime today) =>
    items.where((FridgeItem item) => fridgeFreshness(item, today) != FridgeFreshness.fresh).toList()..sort(
      (FridgeItem a, FridgeItem b) =>
          daysLeft(a, today).getOrElse(() => 0).compareTo(daysLeft(b, today).getOrElse(() => 0)),
    );
