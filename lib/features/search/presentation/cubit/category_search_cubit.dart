import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_search_state.dart';

class CategorySearchCubit extends Cubit<CategorySearchState> {
  CategorySearchCubit() : super(CategorySearchInitial());

  // Update the search query
  void updateSearchQuery(String query) {
    emit(CategorySearchQueryUpdated(query));
  }

  // Select a category
  void selectCategory(String category) {
    emit(CategorySelected(category));
  }

  void searchShops(String title, double d, double e) {}
}
