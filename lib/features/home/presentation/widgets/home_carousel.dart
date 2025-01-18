import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final PageController pageController;

  const ImageCarousel({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: PageView.builder(
        controller: pageController,
        itemCount: 1000,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset('assets/images/ads.png', fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}