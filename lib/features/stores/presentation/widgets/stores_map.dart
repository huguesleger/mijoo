import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/nearby_store.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/presentation/widgets/store_pin.dart';
import 'package:mijoo/features/stores/presentation/widgets/stores_labels.dart';

class StoresMap extends StatelessWidget {
  const StoresMap({
    required this.center,
    required this.radius,
    required this.stores,
    required this.onStore,
    super.key,
  });

  static const double height = 380;
  static const String tiles = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  final Coordinates center;
  final StoreRadius radius;
  final List<NearbyStore> stores;
  final ValueChanged<NearbyStore> onStore;

  @override
  Widget build(BuildContext context) {
    final LatLng origin = LatLng(center.latitude, center.longitude);
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: MjRadius.card,
        child: FlutterMap(
          key: ValueKey<(double, double, StoreRadius)>((center.latitude, center.longitude, radius)),
          options: MapOptions(
            initialCenter: origin,
            initialZoom: mapZoom(radius),
            interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
          ),
          children: <Widget>[
            TileLayer(urlTemplate: tiles, userAgentPackageName: 'com.mijoo.mijoo'),
            CircleLayer(
              circles: <CircleMarker>[
                CircleMarker(
                  point: origin,
                  radius: radius.meters.toDouble(),
                  useRadiusInMeter: true,
                  color: MjColors.primary.withValues(alpha: 0.06),
                  borderColor: MjColors.primary.withValues(alpha: 0.35),
                  borderStrokeWidth: 1.5,
                ),
              ],
            ),
            MarkerLayer(
              markers: <Marker>[
                for (final NearbyStore nearby in stores.reversed)
                  Marker(
                    point: LatLng(nearby.store.coordinates.latitude, nearby.store.coordinates.longitude),
                    width: StorePin.size,
                    height: StorePin.size,
                    child: StorePin(
                      kind: nearby.store.kind,
                      label: storeName(nearby.store),
                      onTap: () => onStore(nearby),
                    ),
                  ),
                Marker(
                  point: origin,
                  width: 22,
                  height: 22,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MjColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: MjColors.onInk, width: 4),
                    ),
                  ),
                ),
              ],
            ),
            SimpleAttributionWidget(source: Text(t.stores.mapAttribution)),
          ],
        ),
      ),
    );
  }
}
