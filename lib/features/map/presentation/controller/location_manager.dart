import 'dart:async';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../domain/models/app_lat_long.dart';
import '../../domain/service/app_location_service.dart';

class LocationManager {
  final Completer<YandexMapController> mapControllerCompleter;

  LocationManager(this.mapControllerCompleter);

  Future<void> initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await fetchCurrentLocation();
  }

  Future<void> fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    await moveToCurrentLocation(location);
    addUserLocationPlacemark(location);
  }

  Future<void> moveToCurrentLocation(AppLatLong appLatLong) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat + 0.005,
            longitude: appLatLong.long,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  void addUserLocationPlacemark(AppLatLong location) {
    // This should be implemented in the widget state that calls this method.
    // For example, by passing a callback to update userLocationPlacemark in the widget.
  }
}
