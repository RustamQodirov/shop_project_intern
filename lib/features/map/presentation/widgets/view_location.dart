import 'package:flutter/material.dart';
import 'package:shop/features/map/domain/models/app_lat_long.dart';
import 'package:shop/features/map/presentation/widgets/small_container.dart';

class ViewLocation extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String distance;
  final String timeToArrive;
  final String address;
  final AppLatLong appLatLong;

  const ViewLocation(
      {super.key,
        required this.imgUrl,
        required this.title,
        required this.address,
        required this.appLatLong,
        required this.distance,
        required this.timeToArrive});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      width: width - 50,
      height: 149,
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
                    image: AssetImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width - 172,
                      child: Text(
                        title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width - 173,
                      height: 38,
                      child: Text(
                        address,
                        style: const TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 13,
                          color: Color(0xff74747b),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SmallContainer(
                  text: distance, icon: Icons.location_on, onTap: () {}),
              SmallContainer(
                  text: timeToArrive,
                  icon: Icons.directions_walk,
                  onTap: () {}),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Open details screen

                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
          )
        ],
      ),
    );
  }
}