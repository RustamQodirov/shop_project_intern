import 'package:flutter/material.dart';
import '../../data/model/banner_model.dart';

class ImageCarousel extends StatelessWidget {
  final PageController pageController;
  final List<BannerModel> banners;

  const ImageCarousel(
      {super.key, required this.pageController, required this.banners});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 169,
      child: PageView.builder(
        controller: pageController,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                banner.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
