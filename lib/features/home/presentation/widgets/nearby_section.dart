import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/model/home_page_data.dart';

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
class NearbyStoreItem extends StatelessWidget {
  const NearbyStoreItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/med.png',
                  fit: BoxFit.cover,
                  width: 300,
                  height: 200,
                ),
              ),
              const Positioned(
                left: 10,
                top: 10,
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Mediapark',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/blueloc.svg'),
              const SizedBox(width: 8),
              const Text(
                '1,2 км',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}