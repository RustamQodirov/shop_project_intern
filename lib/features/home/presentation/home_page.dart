import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/category_cubit.dart';
import 'widgets/category_list_home.dart';
import 'widgets/home_carousel.dart';
import 'widgets/home_header.dart';
import 'widgets/nearby_section.dart';
import 'widgets/recommended_store_section.dart';
import 'widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _startInfiniteScroll();
  }

  void _startInfiniteScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        final nextPage = (_pageController.page! + 1).toInt();
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _startInfiniteScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Gilroy'),
        debugShowCheckedModeBanner: false,
        home: MainContent(pageController: _pageController),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  final PageController pageController;

  const MainContent({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              const SizedBox(height: 15),
              SearchField(),
              const SizedBox(height: 15),
              ImageCarousel(pageController: pageController),
              const SizedBox(height: 15),
              CategoryList(),
              const SizedBox(height: 15),
              NearbySection(),
              const SizedBox(height: 15),
              RecommendedStoresSection(),
            ],
          ),
        ),
      ),
    );
  }
}
