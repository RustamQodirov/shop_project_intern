import 'package:flutter/material.dart';

class CarouselManager {
  final PageController pageController = PageController(viewportFraction: 1.0);
  final int _pageCount = 3;

  void startCarousel() {
    _startInfiniteScroll();
  }

  void _startInfiniteScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (pageController.hasClients) {
        int nextPage = (pageController.page! + 1).toInt();
        if (nextPage >= _pageCount) {
          nextPage = 0;
        }
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
