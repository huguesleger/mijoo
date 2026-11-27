import 'package:mijoo/features/stores/domain/entities/store.dart';

final class NearbyStore {
  const NearbyStore({required this.store, required this.meters});

  final Store store;
  final int meters;
}
