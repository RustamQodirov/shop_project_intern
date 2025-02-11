import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop/features/shop/map/data/datasource/branch_data_source.dart';
import 'package:shop/features/shop/map/data/models/branch_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../domain/models/app_lat_long.dart';
import '../../domain/service/app_location_service.dart';
import '../widgets/bottom_details.dart';
import '../widgets/view_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<YandexMapController> mapControllerCompleter = Completer();
  PlacemarkMapObject? userLocationPlacemark;
  final List<PlacemarkMapObject> placemarks = [];
  bool isOverlayVisible = false;
  late BranchDataSource branchDataSource;
  List<Branch> branches = [];
  Branch? selectedBranch;
  AppLatLong? userLocation;
  Map<String, bool> branchSelectedMap =
      {}; // Track selected state for each branch

  @override
  void initState() {
    super.initState();
    branchDataSource = BranchDataSource();
    _initializePermissions();
    _loadBranches();
  }

  Future<void> _initializePermissions() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    _getCurrentLocation();
  }

  Future<void> _loadBranches() async {
    try {
      branches = await branchDataSource.fetchBranches();
      if (userLocation != null) {
        for (var branch in branches) {
          branch.distance =
              await _getDistance(branch.latitude, branch.longitude);
        }
      }
      _initializePlacemarks();
    } catch (e) {
      print('Failed to load branches: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    AppLatLong location;
    const defaultLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defaultLocation;
    }
    setState(() {
      userLocation = location;
    });
    _moveToLocation(location);
    _addUserLocationPlacemark(location);
  }

  void _addUserLocationPlacemark(AppLatLong location) {
    setState(() {
      userLocationPlacemark = PlacemarkMapObject(
        mapId: const MapObjectId('user_location'),
        point: Point(latitude: location.lat, longitude: location.long),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/images/usr.png'),
            scale: 0.5,
          ),
        ),
        opacity: 0.9,
      );
    });
  }

  Future<void> _moveToLocation(AppLatLong location) async {
    final controller = await mapControllerCompleter.future;
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              Point(latitude: location.lat + 0.005, longitude: location.long),
          zoom: 15,
        ),
      ),
    );
  }

  void _initializePlacemarks() {
    setState(() {
      placemarks.clear();
      for (var branch in branches) {
        placemarks.add(
          PlacemarkMapObject(
            mapId: MapObjectId(branch.guid),
            point:
                Point(latitude: branch.latitude, longitude: branch.longitude),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    branchSelectedMap[branch.guid] == true
                        ? 'assets/images/on.png'
                        : 'assets/images/off.png'),
                scale: 0.7,
              ),
            ),
            onTap: (PlacemarkMapObject self, Point point) {
              setState(() {
                branchSelectedMap[self.mapId.value] =
                    !(branchSelectedMap[self.mapId.value] ?? false);
                selectedBranch = branches
                    .firstWhere((branch) => branch.guid == self.mapId.value);
                isOverlayVisible = branchSelectedMap[self.mapId.value] ?? false;
              });
              _initializePlacemarks();
            },
            opacity: 0.8,
          ),
        );
      }
    });
  }

  void _showBranchDetails(Branch branch) {
    setState(() {
      branchSelectedMap[branch.guid] = true;
      selectedBranch = branch;
      isOverlayVisible = true;
      _initializePlacemarks();
    });
  }

  Future<double> _getDistance(
      double storeLatitude, double storeLongitude) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 0.0;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return 0.0;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        storeLatitude,
        storeLongitude,
      );

      return distanceInMeters / 1000;
    } catch (e) {
      print("Error calculating distance: $e");
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            setState(() {
              isOverlayVisible = false;
              selectedBranch = null;
              branchSelectedMap.clear();
              _initializePlacemarks();
            });
          },
          child: Stack(
            children: [
              YandexMap(
                mapType: MapType.vector,
                logoAlignment: const MapAlignment(
                  horizontal: HorizontalAlignment.center,
                  vertical: VerticalAlignment.top,
                ),
                mapObjects: [
                  if (userLocationPlacemark != null) userLocationPlacemark!,
                  ...placemarks,
                ],
                onMapCreated: (controller) {
                  mapControllerCompleter.complete(controller);
                },
              ),
              _buildTopControls(context),
              _buildCurrentLocationButton(),
              _buildBranchList(),
              _buildBranchDetailsOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopControls(BuildContext context) {
    return Positioned(
      top: 53,
      left: 20,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: _buildIconContainer(const Icon(Icons.arrow_back)),
      ),
    );
  }

  Widget _buildIconContainer(Widget icon) {
    return Container(
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
      child: Center(child: icon),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      bottom: 170,
      right: 0,
      child: GestureDetector(
        onTap: () {
          if (mounted) {
            _getCurrentLocation();
          }
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/location.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranchList() {
    final displayedBranches = branches.take(10).toList();
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: displayedBranches.map((branch) {
            return ViewLocation(
              imgUrl: branch.logo.isNotEmpty
                  ? branch.logo
                  : 'assets/images/default.png',
              title: branch.name,
              address: branch.address,
              appLatLong:
                  AppLatLong(lat: branch.latitude, long: branch.longitude),
              distance: "${branch.distance.toStringAsFixed(2)} km",
              timeToArrive: "10 min",
              onDetailsPressed: () => _showBranchDetails(branch),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBranchDetailsOverlay() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      bottom: isOverlayVisible ? 0 : -350,
      left: 0,
      right: 0,
      child: selectedBranch != null
          ? BottomDetailsOverlay(branch: selectedBranch!)
          : const SizedBox(),
    );
  }
}
