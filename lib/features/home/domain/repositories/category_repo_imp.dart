import '../../data/datasources/category_datasource.dart';
import '../../data/model/category_model.dart';
import '../../data/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  Future<List<Category>> fetchCategories(String token) {
    return dataSource.fetchCategories(token);
  }
}
