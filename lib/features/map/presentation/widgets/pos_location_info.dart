import 'package:flutter/material.dart';
import 'package:shop/features/map/presentation/widgets/view_location.dart';

import '../../domain/models/app_lat_long.dart';

class PositionedLocationInfo extends StatelessWidget {
  final bool isOverlayVisible;

  const PositionedLocationInfo({Key? key, required this.isOverlayVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
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
    );
  }
}