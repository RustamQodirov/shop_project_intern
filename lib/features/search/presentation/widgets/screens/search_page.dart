import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/features/search/domain/cubit/category_search_cubit.dart';
import 'package:shop/features/search/presentation/widgets/store_list.dart';
import '../quick_search.dart';

class SearchPage extends StatefulWidget {
  final String category;
  final bool hideCategories;

  const SearchPage({
    Key? key,
    required this.category,
    this.hideCategories = false,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _focusNode = FocusNode();
  late final TextEditingController _searchController;
  late bool _hideCategories;

  @override
  void initState() {
    super.initState();
    _hideCategories = widget.hideCategories;
    _searchController = TextEditingController(text: widget.category)
      ..addListener(() {
        context
            .read<CategorySearchCubit>()
            .updateSearchQuery(_searchController.text);
      });
    Future.microtask(() => FocusScope.of(context).requestFocus(_focusNode));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategorySearchCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
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
                            padding: const EdgeInsets.all(13.5),
                            child: SvgPicture.asset(
                              'assets/icons/Union.svg',
                              width: 16,
                              height: 16,
                              color: Colors.grey,
                            ),
                          ),
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
                                      _hideCategories = false;
                                    });
                                  },
                                )
                              : null,
                          fillColor: const Color(0xFFF4F4F5),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && !_hideCategories) {
                            setState(() {
                              _hideCategories =
                                  true; // Hide categories when typing
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (!_hideCategories) ...[
                  QuickSearch(),
                  const SizedBox(height: 16),
                ],
                Expanded(child: StoreList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
