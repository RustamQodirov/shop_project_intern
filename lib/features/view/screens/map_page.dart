import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/features/data/models/app_lat_long.dart';
import 'package:shop/features/data/service/app_location_service.dart';
import 'package:shop/features/view/bottom_details.dart';
import 'package:shop/features/view/view_location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  PlacemarkMapObject? userLocationPlacemark;
  final List<PlacemarkMapObject> placemarks = [];
  final Map<String, bool> placemarkToggles = {};
  bool isOverlayVisible = false;
  ViewLocation? selectedMarket;

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
    _initializePlacemarks();
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
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

  void _addUserLocationPlacemark(AppLatLong location) {
    setState(() {
      userLocationPlacemark = PlacemarkMapObject(
        opacity: 0.9,
        mapId: const MapObjectId('user_location'),
        point: Point(latitude: location.lat, longitude: location.long),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/images/usr.png'),
          scale: 0.5,
        )),
      );
    });
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
    _addUserLocationPlacemark(location);
  }

  void updatePlacemarkIcon(String mapObjectId, String newIconPath) {
    setState(() {
      final index = placemarks
          .indexWhere((placemark) => placemark.mapId.value == mapObjectId);
      if (index != -1) {
        placemarks[index] = placemarks[index].copyWith(
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(newIconPath),
            scale: 0.7,
          )),
        );
      }
    });
  }

  void _initializePlacemarks() {
    placemarks.addAll([
      PlacemarkMapObject(
        opacity: 0.8,
        mapId: const MapObjectId('idea'),
        point: const Point(latitude: 39.762602, longitude: 67.278833),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          zIndex: 1,
          image: BitmapDescriptor.fromAssetImage('assets/images/off.png'),
          scale: 0.7,
        )),
      ),
      PlacemarkMapObject(
        opacity: 0.8,
        mapId: const MapObjectId('texnomart'),
        point: const Point(latitude: 39.7629453, longitude: 67.2694326),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/images/off.png'),
          scale: 0.7,
        )),
      ),
    ]);

    // Initialize toggle states
    placemarkToggles['idea'] = false;
    placemarkToggles['texnomart'] = false;

    // Add onTap callbacks
    placemarks[0] = placemarks[0].copyWith(
      onTap: (PlacemarkMapObject self, Point point) {
        final isSelected = placemarkToggles[self.mapId.value] ?? false;
        final newIconPath =
            isSelected ? 'assets/images/off.png' : 'assets/images/on.png';
        updatePlacemarkIcon(self.mapId.value, newIconPath);
        placemarkToggles[self.mapId.value] = !isSelected;
        setState(() {
          if (placemarkToggles['idea'] == false &&
              placemarkToggles['texnomart'] == false) {
            isOverlayVisible = false;
            selectedMarket = null;
          } else {
            isOverlayVisible = !isSelected;
            selectedMarket = isSelected
                ? null
                : const ViewLocation(
                    imgUrl: "assets/images/idea.png",
                    title: "Idea",
                    address: "Ташкент, Юнусабадский р-н, ул А. Темура, 43/2",
                    appLatLong: AppLatLong(
                        lat: 41.318118727817414, long: 69.29323833747138),
                    distance: "1.5 km",
                    timeToArrive: "10 min",
                  );
          }
        });
      },
    );

    placemarks[1] = placemarks[1].copyWith(
      onTap: (PlacemarkMapObject self, Point point) {
        final isSelected = placemarkToggles[self.mapId.value] ?? false;
        final newIconPath =
            isSelected ? 'assets/images/off.png' : 'assets/images/on.png';
        updatePlacemarkIcon(self.mapId.value, newIconPath);
        placemarkToggles[self.mapId.value] = !isSelected;
        setState(() {
          if (placemarkToggles['idea'] == false &&
              placemarkToggles['texnomart'] == false) {
            isOverlayVisible = false;
            selectedMarket = null;
          } else {
            isOverlayVisible = !isSelected;
            selectedMarket = isSelected
                ? null
                : const ViewLocation(
                    imgUrl: "assets/images/tex.png",
                    title: "Texnomart",
                    address: "Ташкент, Юнусабад 11",
                    appLatLong: AppLatLong(
                        lat: 41.318118727817414, long: 69.29323833747138),
                    distance: "2.3 km",
                    timeToArrive: "28 min",
                  );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            YandexMap(
              logoAlignment: const MapAlignment(
                  horizontal: HorizontalAlignment.center,
                  vertical: VerticalAlignment.top),
              mapType: MapType.vector,
              mapObjects: [
                if (userLocationPlacemark != null) userLocationPlacemark!,
                ...placemarks,
              ],
              onMapCreated: (controller) {
                mapControllerCompleter.complete(controller);
              },
            ),
            Positioned(
                top: 53,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff040415).withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                )),
            Positioned(
                top: 53,
                right: 20,
                child: GestureDetector(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff040415).withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.tune),
                  ),
                )),
            Positioned(
              bottom: 170,
              right: 0,
              child: GestureDetector(
                onTap: _fetchCurrentLocation,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/location.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ViewLocation(
                        imgUrl: "assets/images/idea.png",
                        title: "Idea",
                        address:
                            "Ташкент, Юнусабадский р-н, ул А. Темура, 43/2",
                        appLatLong: AppLatLong(
                            lat: 41.318118727817414, long: 69.29323833747138),
                        distance: "1.5 km",
                        timeToArrive: "10 min"),
                    ViewLocation(
                        imgUrl: "assets/images/tex.png",
                        title: "Texnomart",
                        address: "Ташкент, Юнусабад 11",
                        appLatLong: AppLatLong(
                            lat: 41.318118727817414, long: 69.29323833747138),
                        distance: "2.3 km",
                        timeToArrive: "28 min"),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: isOverlayVisible ? 0 : -350,
              left: 0,
              curve: Curves.easeInToLinear,
              right: 0,
              child: isOverlayVisible
                  ? BottomDetailsOverlay(
                      viewLocation: selectedMarket ??
                          const ViewLocation(
                            imgUrl: "",
                            title: "No Market Selected",
                            address: "Unknown",
                            appLatLong: AppLatLong(lat: 0.0, long: 0.0),
                            distance: "N/A",
                            timeToArrive: "N/A",
                          ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
