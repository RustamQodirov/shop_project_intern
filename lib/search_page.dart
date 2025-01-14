import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  final String category;

  const SearchPage({Key? key, required this.category}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = -1;
  String _selectedLabel = '';
  String _selectedStoreName = '';
  String _defaultTitle = 'Часто ищут';
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.category);

    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar Section
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.grey),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
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
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            fillColor: const Color(0xFFF4F4F5),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/minus.svg',
                                      width: 16,
                                      height: 16,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {
                                        _selectedIndex = -1;
                                        _selectedLabel = '';
                                        _defaultTitle = 'Часто ищут';
                                      });
                                    },
                                  )
                                : null,
                          ),
                          style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                _searchController.text.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          height: 104,
                          child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              List<String> iconPaths = [
                                'assets/images/laptop.png',
                                'assets/images/phone.png',
                                'assets/images/machine.png',
                                'assets/images/sofa.png',
                                'assets/images/car1.png',
                                'assets/images/bear.png',
                              ];

                              List<String> labels = [
                                'Электроника',
                                'Смартфоны',
                                'Бытовая техника',
                                'Мебель',
                                'Авто товары',
                                'Игрушки',
                              ];

                              bool isSelected = _selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = isSelected ? -1 : index;
                                    _selectedLabel =
                                        isSelected ? '' : labels[index];
                                    _defaultTitle = isSelected
                                        ? 'Часто ищут'
                                        : labels[index];
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: isSelected
                                              ? Color(0xFF4059E6)
                                                  .withOpacity(0.1)
                                              : Colors.grey.shade200,
                                          border: Border.all(
                                            color: isSelected
                                                ? Color(0xFF4059E6)
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            iconPaths[index],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 79,
                                        child: Text(
                                          labels[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: isSelected
                                                ? Color(0xFF4059E6)
                                                : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : SizedBox(),
                _searchController.text.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _defaultTitle,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(9, (index) {
                      List<String> storeNames = [
                        'Elmakon',
                        'Texnomart',
                        'Idea',
                        'Mediapark',
                        'Shop 1',
                        'Shop 2',
                        'Shop 3',
                        'Shop 4',
                        'Shop 5',
                      ];

                      List<String> storeIcons = [
                        'assets/images/el.png',
                        'assets/images/tex.png',
                        'assets/images/idea.png',
                        'assets/images/medial.png',
                        'assets/images/el.png',
                        'assets/images/tex.png',
                        'assets/images/idea.png',
                        'assets/images/el.png',
                        'assets/images/tex.png',
                      ];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedStoreName = storeNames[index];
                            });
                          },
                          child: Row(
                            children: [
                              storeIcons[index].isNotEmpty
                                  ? Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          storeIcons[index],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : SizedBox(width: 50),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  storeNames[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey)
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
