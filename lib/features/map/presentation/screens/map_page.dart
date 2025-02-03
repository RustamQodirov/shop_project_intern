import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop/features/map/data/datasource/branch_data_source.dart';
import 'package:shop/features/map/data/models/branch_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../domain/models/app_lat_long.dart';
import '../../domain/service/app_location_service.dart';

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
          branch.distance = await _getDistance(branch.latitude, branch.longitude);
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
          target: Point(latitude: location.lat + 0.005, longitude: location.long),
          zoom: 15,
        ),
      ),
    );
  }

  void _initializePlacemarks() {
    for (var branch in branches) {
      placemarks.add(
        PlacemarkMapObject(
          mapId: MapObjectId(branch.guid),
          point: Point(latitude: branch.latitude, longitude: branch.longitude),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/images/on.png'),
              scale: 0.7,
            ),
          ),
          onTap: (PlacemarkMapObject self, Point point) {
            setState(() {
              isOverlayVisible = !isOverlayVisible;
              selectedBranch = branches
                  .firstWhere((branch) => branch.guid == self.mapId.value);
              print('Overlay visibility toggled: $isOverlayVisible');
              print('Selected branch: ${selectedBranch?.name}');
            });
          },
          opacity: 0.8,
        ),
      );
    }
  }

  void _showBranchDetails(Branch branch) {
    setState(() {
      isOverlayVisible = true;
      selectedBranch = branch;
      print('Overlay visibility set to true');
      print('Selected branch: ${selectedBranch?.name}');
    });
  }

  Future<double> _getDistance(double storeLatitude, double storeLongitude) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 0.0;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
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
              appLatLong: AppLatLong(lat: branch.latitude, long: branch.longitude),
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

class ViewLocation extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String distance;
  final String timeToArrive;
  final String address;
  final AppLatLong appLatLong;
  final VoidCallback onDetailsPressed;

  const ViewLocation({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.address,
    required this.appLatLong,
    required this.distance,
    required this.timeToArrive,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      width: width - 50,
      height: 155,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      address,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        color: Color(0xff74747b),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SmallContainer(
                text: distance,
                icon: Icons.location_on,
              ),
              SmallContainer(
                text: timeToArrive,
                icon: Icons.directions_walk,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onDetailsPressed,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xff4059E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Подробнее',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SmallContainer extends StatelessWidget {
  const SmallContainer({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xfff4f4f5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Transform.scale(scaleY: 0.9, child: Icon(icon, color: Colors.black)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomDetailsOverlay extends StatelessWidget {
  final Branch branch;

  const BottomDetailsOverlay({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 330,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(branch.logo.isNotEmpty
                          ? branch.logo
                          : 'assets/images/default.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branch.name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        branch.address,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                          color: Color(0xff74747b),
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 5),
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xfff4f4f5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xff4059E6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: const Color(0xff040415).withOpacity(0.1),
              thickness: 1,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF4F4F5),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      branch.address,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff040405),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF4F4F5),
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      branch.phoneNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff62c994),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF4F4F5),
                    ),
                    child: const Icon(
                      Icons.access_time_filled_rounded,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "пн-пт 10:00-21:00, сб-вс 10:00-20:00",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff040405),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}