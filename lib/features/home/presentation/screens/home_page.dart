import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/home/presentation/widgets/caruosel_manager.dart';
import '../cubit/category_cubit.dart';
import '../widgets/category_list_home.dart';
import '../widgets/home_carousel.dart';
import '../widgets/home_header.dart';
import '../widgets/nearby_section.dart';
import '../widgets/recommended_store_section.dart';
import '../widgets/search_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Gilroy'),
        debugShowCheckedModeBanner: false,
        home: MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  late final CarouselManager _carouselManager;

  @override
  void initState() {
    super.initState();
    _carouselManager = CarouselManager();
    _carouselManager.startCarousel();
  }

  @override
  void dispose() {
    _carouselManager.dispose();
    super.dispose();
  }

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
              ImageCarousel(pageController: _carouselManager.pageController),
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