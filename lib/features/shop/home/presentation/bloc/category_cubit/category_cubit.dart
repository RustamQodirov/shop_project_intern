import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/category_repository.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit({required this.categoryRepository}) : super(CategoryInitial());

  void fetchCategories(String token) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.fetchCategories(token);
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
