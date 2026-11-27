import 'package:fpdart/fpdart.dart';

typedef StoreMoment = ({int weekday, int minute});

sealed class OpeningStatus {
  const OpeningStatus();
}

final class StoreOpen extends OpeningStatus {
  const StoreOpen(this.closesAt);

  final Option<int> closesAt;
}

final class StoreClosed extends OpeningStatus {
  const StoreClosed(this.opensAt);

  final Option<StoreMoment> opensAt;
}
