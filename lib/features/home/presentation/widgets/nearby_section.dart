import 'package:flutter/material.dart';

import '../../data/model/home_page_data.dart';
import 'near_store_items.dart';

class NearbySection extends StatelessWidget {
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
            itemCount: HomePageData.nearbyStores.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return NearbyStoreItem();
            },
          ),
        ),
      ],
    );
  }
}