import 'package:flutter/material.dart';

class RecommendedStoreItem extends StatelessWidget {
  final String name;
  final String image;
  final String logo;

  const RecommendedStoreItem({
    super.key,
    required this.name,
    required this.image,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageWithLogo(),
          const SizedBox(height: 8),
          _buildNameText(),
          _buildCategoryText(),
        ],
      ),
    );
  }

  Widget _buildImageWithLogo() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: 209,
            height: 209,
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage(logo),
            onBackgroundImageError: (_, __) {},
          ),
        ),
      ],
    );
  }

  Widget _buildNameText() {
    return Text(
      name,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color(0xFF040415),
      ),
    );
  }

  Widget _buildCategoryText() {
    return const Text(
      'Магазин электроники',
      style: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 18,
        color: Colors.grey,
      ),
    );
  }
}
