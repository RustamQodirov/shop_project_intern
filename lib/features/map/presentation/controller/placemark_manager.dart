import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlacemarkManager {
  final List<PlacemarkMapObject> placemarks = [];
  final Map<String, bool> placemarkToggles = {};

  PlacemarkManager() {
    _initializePlacemarks();
  }

  void _initializePlacemarks() {
    placemarks.addAll([
      PlacemarkMapObject(
        mapId: const MapObjectId('idea'),
        point: const Point(latitude: 39.762602, longitude: 67.278833),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/images/off.png'),
            scale: 0.7,
          ),
        ),
      ),
      PlacemarkMapObject(
        mapId: const MapObjectId('texnomart'),
        point: const Point(latitude: 39.7629453, longitude: 67.2694326),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/images/off.png'),
            scale: 0.7,
          ),
        ),
      ),
    ]);
    placemarkToggles['idea'] = false;
    placemarkToggles['texnomart'] = false;
  }
}
