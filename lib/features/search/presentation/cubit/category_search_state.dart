part of 'category_search_cubit.dart';

@immutable
sealed class CategorySearchState {}

// Initial state when the cubit is first created
final class CategorySearchInitial extends CategorySearchState {}

// State when the search query is updated
final class CategorySearchQueryUpdated extends CategorySearchState {
  final String query;

  CategorySearchQueryUpdated(this.query);
}

// State when a category is selected
final class CategorySelected extends CategorySearchState {
  final String category;

  CategorySelected(this.category);
}
