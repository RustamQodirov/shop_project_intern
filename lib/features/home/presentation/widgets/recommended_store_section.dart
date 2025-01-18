import 'package:flutter/material.dart';
import 'package:shop/features/home/presentation/widgets/reco_stores.dart';
import '../../data/model/home_page_data.dart';

class RecommendedStoresSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Вам может понравится',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF040415),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: ListView.builder(
            itemCount: HomePageData.recommendedStores.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final store = HomePageData.recommendedStores[index];
              return RecommendedStoreItem(
                name: store['name']!,
                image: store['image']!,
                logo: store['logo']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
