import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/category_cubit.dart';
import '../../../search/presentation/search_page.dart';
import '../../data/model/home_page_data.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: ListView.builder(
        itemCount: HomePageData.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = HomePageData.categories[index];
          return GestureDetector(
            onTap: () {
              context.read<CategoryCubit>().selectCategory(category['label']!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchPage(category: category['label']!),
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
}
