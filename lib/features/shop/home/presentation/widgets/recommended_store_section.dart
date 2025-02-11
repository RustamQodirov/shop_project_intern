import 'package:flutter/material.dart';
import '../../data/model/recommended_store_model.dart';

class RecommendedStoresSection extends StatelessWidget {
  final List<RecommendedStore> recommendedStores;

  const RecommendedStoresSection({
    super.key,
    required this.recommendedStores,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Вам может понравиться',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF040415),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            itemCount: recommendedStores.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final store = recommendedStores[index];
              return RecommendedStoreItem(
                name: store.name,
                imageUrl: store.logo,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecommendedStoreItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const RecommendedStoreItem({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 10),
          _buildNameText(),
          _buildCategoryText(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          width: 200,
          height: 200,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: const Icon(Icons.image, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNameText() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF040415),
        ),
      ),
    );
  }

  Widget _buildCategoryText() {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text(
        'Магазин электроники',
        style: TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}
