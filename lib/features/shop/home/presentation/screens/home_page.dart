import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shop/features/shop/home/presentation/bloc/nearby_cubit/nearby_cubit.dart';
import '../../data/datasources/banner_datasource.dart';
import '../../data/datasources/category_datasource.dart';
import '../../data/datasources/nearby_datasource.dart';
import '../../data/datasources/recommended_store_datasource.dart';
import '../../domain/repositories/banner_repo_imp.dart';
import '../../domain/repositories/category_repo_imp.dart';
import '../../domain/repositories/nearby_repository_impl.dart';
import '../../domain/repositories/recommended_store_repository_impl.dart';
import '../bloc/banner_cubit/banner_cubit.dart';
import '../bloc/category_cubit/category_cubit.dart';
import '../bloc/nearby_cubit/nearby_state.dart';
import '../bloc/recommended_cubit/recommended_store_cubit.dart';
import '../bloc/recommended_cubit/recommended_store_state.dart';
import '../widgets/caruosel_manager.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BannerCubit(
            bannerRepository: BannerRepositoryImpl(
              bannerDataSource: BannerDataSource(dio: Dio()),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => CategoryCubit(
            categoryRepository: CategoryRepositoryImpl(
              dataSource: CategoryDataSource(dio: Dio()),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => NearbyCubit(
            nearbyRepository: NearbyRepositoryImpl(
              nearbyDataSource: NearbyDataSource(dio: Dio()),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => RecommendedStoreCubit(
            repository: RecommendedStoreRepositoryImpl(
              dataSource: RecommendedStoreDataSource(dio: Dio()),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Gilroy'),
        debugShowCheckedModeBanner: false,
        home: const MainContent(),
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
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE4OTc0Njg4ODgsImlkIjoiYmFjYWZlZTUtYWI4MC00NjBmLWIwODgtNjFhNDJmZmZjMGFlIiwidXNlcl9pZCI6IjU5NzA1ODdkLTEzNDMtNDM4ZC04NjI4LTZlZWViYjAzYmU2OSJ9.Mjc1j9lu12lc2eNddzeKi7z8GB1zu95uXi5gSOC0mKs'; // Replace with your actual token

  @override
  void initState() {
    super.initState();
    _carouselManager = CarouselManager();
    _carouselManager.startCarousel();

    context.read<BannerCubit>().fetchBanners(token);
    context.read<CategoryCubit>().fetchCategories(token);
    context.read<NearbyCubit>().fetchNearbyStores(token);
    context.read<RecommendedStoreCubit>().fetchRecommendedStores(token);
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
              BlocBuilder<BannerCubit, BannerState>(
                builder: (context, state) {
                  if (state is BannerLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is BannerLoaded) {
                    return ImageCarousel(
                      pageController: _carouselManager.pageController,
                      banners: state.banners,
                    );
                  } else if (state is BannerError) {
                    return Text('Error: ${state.message}');
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 15),
              CategoryList(token: token),
              const SizedBox(height: 15),
              BlocBuilder<NearbyCubit, NearbyState>(
                builder: (context, state) {
                  if (state is NearbyLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is NearbyLoaded) {
                    return NearbySection(nearbyStores: state.nearbyStores);
                  } else if (state is NearbyError) {
                    return Text('Error: ${state.message}');
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 15),
              BlocBuilder<RecommendedStoreCubit, RecommendedStoreState>(
                builder: (context, state) {
                  if (state is RecommendedStoreLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is RecommendedStoreLoaded) {
                    return RecommendedStoresSection(
                      recommendedStores: state.stores,
                    );
                  } else if (state is RecommendedStoreError) {
                    return Text('Error: ${state.message}');
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
