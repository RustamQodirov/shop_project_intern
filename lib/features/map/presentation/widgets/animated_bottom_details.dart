import 'package:flutter/material.dart';
import 'package:shop/features/map/presentation/widgets/view_location.dart';

import '../../domain/models/app_lat_long.dart';
import 'bottom_details.dart';

class AnimatedBottomDetailsOverlay extends StatelessWidget {
  final bool isOverlayVisible;
  final ViewLocation? selectedMarket;

  const AnimatedBottomDetailsOverlay({
    Key? key,
    required this.isOverlayVisible,
    required this.selectedMarket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
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
          : const SizedBox(),
    );
  }
}