import 'package:flutter/material.dart';

import '../../domain/models/app_lat_long.dart';
import 'map_container.dart';

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