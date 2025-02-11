import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/model/category_model.dart';
import '../bloc/category_search_cubit/category_search_cubit.dart';

class QuickSearch extends StatelessWidget {
  final List<Category> categories;

  const QuickSearch({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((data) {
          final index = categories.indexOf(data);

          return BlocBuilder<CategorySearchCubit, CategorySearchState>(
            builder: (context, state) {
              final isSelected =
                  state is CategorySelected && state.category == data.title;

              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                  } else {
                    // Select the category
                    context
                        .read<CategorySearchCubit>()
                        .selectCategory(data.title);
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
                        child: data.banner != null
                            ? Image.network(
                          data.banner!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.category, // Placeholder icon
                              size: 40,
                              color: isSelected
                                  ? const Color(0xFF4059E6)
                                  : Colors.grey,
                            );
                          },
                        )
                            : Icon(
                          Icons.category,
                          size: 40,
                          color: isSelected
                              ? const Color(0xFF4059E6)
                              : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 79,
                      child: Text(
                        data.title,
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
}