import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/stored_data.dart';
import '../../home/domain/cubit/category_cubit.dart';

class SearchPage extends StatefulWidget {
  final String category;

  const SearchPage({Key? key, required this.category}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _focusNode = FocusNode();
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.category)
      ..addListener(() => setState(() {}));
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildQuickSearch(),
              const SizedBox(height: 16),
              Expanded(child: _buildStoreList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
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
                padding: const EdgeInsets.all(13.0),
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
                        context.read<CategoryCubit>().deselectCategory();
                      },
                    )
                  : null,
              fillColor: const Color(0xFFF4F4F5),
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSearch() {
    return SizedBox(
      height: 104,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: StoreData.quickSearch.map((data) {
          final index = StoreData.quickSearch.indexOf(data);

          return BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              final isSelected =
                  state is CategorySelected && state.category == data['label'];

              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    context.read<CategoryCubit>().deselectCategory();
                  } else {
                    context
                        .read<CategoryCubit>()
                        .selectCategory(data['label']!);
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: isSelected
                            ? const Color(0xFF4059E6).withOpacity(0.1)
                            : Colors.grey.shade200,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4059E6)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child:
                            Image.asset(data['icon']!, width: 50, height: 50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 79,
                      child: Text(
                        data['label']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 12,
                          color: isSelected
                              ? const Color(0xFF4059E6)
                              : Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStoreList() {
    return ListView(
      children: StoreData.stores.map((data) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(data['icon']!, width: 50, height: 50),
          ),
          title: Text(
            data['name']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            // Handle store selection
          },
        );
      }).toList(),
    );
  }
}
