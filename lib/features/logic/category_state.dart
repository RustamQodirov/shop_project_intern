part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryDeselected extends CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySelected extends CategoryState {
  final String category;

  CategorySelected(this.category);
}
