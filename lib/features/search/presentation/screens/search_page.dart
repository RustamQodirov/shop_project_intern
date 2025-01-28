import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import '../../../home/data/datasources/category_datasource.dart';
import '../../../home/data/model/category_model.dart';
import '../../data/datasource/store_datasource.dart';
import '../../data/model/store_model.dart';
import '../cubit/category_search_cubit.dart';
import '../widgets/quick_search.dart';
import '../widgets/store_list.dart';

class SearchPage extends StatefulWidget {
  final String category;
  final bool hideCategories;

  const SearchPage(
      {Key? key, required this.category, this.hideCategories = false})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _focusNode = FocusNode();
  late final TextEditingController _searchController;
  late bool _hideCategories;
  late List<Category> categories = [];
  late List<Store> stores = [];
  final String _token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE4OTc0Njg4ODgsImlkIjoiYmFjYWZlZTUtYWI4MC00NjBmLWIwODgtNjFhNDJmZmZjMGFlIiwidXNlcl9pZCI6IjU5NzA1ODdkLTEzNDMtNDM4ZC04NjI4LTZlZWViYjAzYmU2OSJ9.Mjc1j9lu12lc2eNddzeKi7z8GB1zu95uXi5gSOC0mKs'; // Token as a single variable

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.category)
      ..addListener(() => context
          .read<CategorySearchCubit>()
          .updateSearchQuery(_searchController.text));
    _hideCategories = widget.hideCategories;
    _fetchCategories();
    _fetchStores();
    Future.microtask(() => FocusScope.of(context).requestFocus(_focusNode));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    try {
      final dio = Dio();
      final categoryDataSource = CategoryDataSource(dio: dio);
      categories = await categoryDataSource
          .fetchCategories(_token); // Use the token here
      setState(() {});
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> _fetchStores() async {
    try {
      final dio = Dio();
      final storeDataSource = StoreDataSource(dio: dio);
      stores = await storeDataSource.fetchStores(_token); // Use the token here
      setState(() {});
    } catch (e) {
      print("Error fetching stores: $e");
    }
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
                _buildSearchBar(),
                const SizedBox(height: 16),
                if (!_hideCategories && categories.isNotEmpty) ...[
                  QuickSearch(categories: categories),
                  const SizedBox(height: 16),
                  _buildCategoryTitle(),
                ],
                const SizedBox(height: 16),
                Expanded(child: _buildStoreList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTitle() {
    return BlocBuilder<CategorySearchCubit, CategorySearchState>(
      builder: (context, state) {
        final categoryTitle =
            state is CategorySelected ? state.category : widget.category;
        return Text(
          categoryTitle.isEmpty ? 'Часто ищут' : categoryTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _buildStoreList() {
    if (stores.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return StoreList(stores: stores);
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        _buildBackButton(),
        const SizedBox(width: 10),
        Expanded(child: _buildSearchField()),
      ],
    );
  }

  Widget _buildBackButton() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.grey),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      focusNode: _focusNode,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.5),
          child: SvgPicture.asset('assets/icons/Union.svg',
              width: 16, height: 16, color: Colors.grey),
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: SvgPicture.asset('assets/icons/minus.svg',
                    width: 16, height: 16, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _hideCategories = false);
                },
              )
            : null,
        fillColor: const Color(0xFFF4F4F5),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
      ),
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 16),
      onChanged: (value) {
        if (value.isNotEmpty && !_hideCategories) {
          setState(() => _hideCategories = true);
        }
      },
    );
  }
}
