import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/features/view/map_page.dart';
import 'package:shop/near_store_items.dart';
import 'package:shop/reco_stores.dart';
import 'package:shop/search_page.dart';

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
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gilroy'),
      debugShowCheckedModeBanner: false,
      home: MainContent(pageController: _pageController),
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
              _buildHeader(context),
              const SizedBox(height: 15),
              _buildSearchField(context),
              const SizedBox(height: 15),
              _buildImageCarousel(),
              const SizedBox(height: 15),
              _buildCategoryList(context),
              const SizedBox(height: 15),
              _buildNearbySection(),
              const SizedBox(height: 15),
              _buildRecommendedStoresSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Магазины',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
          icon: SvgPicture.asset(
            'assets/icons/icon.svg',
            width: 22,
            height: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage(category: '')),
        );
      },
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Поиск по магазинам',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Transform.scale(
            scale: 0.65,
            child: SvgPicture.asset(
              'assets/icons/Union.svg',
              width: 16,
              height: 16,
              color: Colors.grey,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
        fillColor: const Color(0xFFF4F4F5),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  Widget _buildImageCarousel() {
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

  Widget _buildCategoryList(BuildContext context) {
    final categories = [
      {'icon': 'assets/images/laptop.png', 'label': 'Электроника'},
      {'icon': 'assets/images/phone.png', 'label': 'Смартфоны'},
      {'icon': 'assets/images/machine.png', 'label': 'Бытовая техника'},
      {'icon': 'assets/images/sofa.png', 'label': 'Мебель'},
      {'icon': 'assets/images/car1.png', 'label': 'Авто товары'},
      {'icon': 'assets/images/bear.png', 'label': 'Игрушки'},
    ];

    return SizedBox(
      height: 104,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(category: category['label']!),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Image.asset(
                      category['icon']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 79,
                  child: Text(
                    category['label']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Поблизости',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF040415),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 260,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return NearbyStoreItem();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedStoresSection() {
    final stores = [
      {
        'name': 'Elmakon',
        'image': 'assets/images/player.png',
        'logo': 'assets/images/el.png',
      },
      {
        'name': 'Texnomart',
        'image': 'assets/images/earphone.png',
        'logo': 'assets/images/tex.png',
      },
      {
        'name': 'idea',
        'image': 'assets/images/earphone.png',
        'logo': 'assets/images/idea.png',
      },
    ];

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
            itemCount: stores.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final store = stores[index];
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

