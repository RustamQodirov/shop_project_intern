import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/stored_data.dart';
import '../../domain/cubit/category_search_cubit.dart';

class QuickSearch extends StatelessWidget {
  const QuickSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: StoreData.quickSearch.map((data) {
          final index = StoreData.quickSearch.indexOf(data);

          return BlocBuilder<CategorySearchCubit, CategorySearchState>(
            builder: (context, state) {
              final isSelected =
                  state is CategorySelected && state.category == data['label'];

              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                  } else {
                    context
                        .read<CategorySearchCubit>()
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
}