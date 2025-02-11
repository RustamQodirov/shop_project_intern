import '../model/category_model.dart';

abstract class CategoryRepository {
  Future<List<Category>> fetchCategories(String token);
}
