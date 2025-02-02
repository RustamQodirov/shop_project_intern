import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search/presentation/screens/search_page.dart';
import '../bloc/category_cubit/category_cubit.dart';
import '../bloc/category_cubit/category_state.dart';

class CategoryList extends StatelessWidget {
  final String token;

  const CategoryList({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return SizedBox(
            height: 104,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          category: category.title,
                          token: token, hideCategories: true,
                        ),
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
                          child: category.banner.isNotEmpty
                              ? Image.network(
                            category.banner,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          )
                              : const Icon(Icons.category),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 79,
                        child: Text(
                          category.title,
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
        } else if (state is CategoryError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}
