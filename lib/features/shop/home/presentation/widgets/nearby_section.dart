import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop/features/shop/home/data/model/nearby_model.dart';

class NearbySection extends StatelessWidget {
  final List<NearbyStore> nearbyStores;

  const NearbySection({super.key, required this.nearbyStores});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Поблизости',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF040415),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 260,
          child: ListView.builder(
            itemCount: nearbyStores.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return NearbyStoreItem(nearbyStore: nearbyStores[index], getDistance: _getDistance);
            },
          ),
        ),
      ],
    );
  }
}

class NearbyStoreItem extends StatelessWidget {
  final NearbyStore nearbyStore;
  final Future<double> Function(double latitude, double longitude) getDistance;

  const NearbyStoreItem({
    super.key,
    required this.nearbyStore,
    required this.getDistance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container with proper scaling
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: (nearbyStore.logo.isNotEmpty)
                ? Image.network(
              nearbyStore.logo,
              fit: BoxFit.contain, // Changed to BoxFit.contain
              width: double.infinity,
              height: 190,
            )
                : Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 190,
              child: const Center(
                child: Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              nearbyStore.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Prevent overflow of long names
              style: const TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF040415),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/blueloc.svg', width: 14, height: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: FutureBuilder<double>(
                    future: getDistance(
                      nearbyStore.address.latitude,
                      nearbyStore.address.longitude,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Calculating...',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                          'Error',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data?.toStringAsFixed(2)} км', // Showing the distance
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      } else {
                        return const Text(
                          'No Data',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
