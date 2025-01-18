import 'package:flutter/material.dart';

class CarouselManager {
  final PageController pageController = PageController(viewportFraction: 1.0);

  void startCarousel() {
    _startInfiniteScroll();
  }

  void _startInfiniteScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (pageController.hasClients) {
        final nextPage = (pageController.page! + 1).toInt();
        pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _startInfiniteScroll();
      }
    });
  }

  void dispose() {
    pageController.dispose();
  }
}
