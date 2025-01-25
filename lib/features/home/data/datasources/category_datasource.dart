import 'package:dio/dio.dart';
import '../model/category_model.dart';

class CategoryDataSource {
  final Dio dio;

  CategoryDataSource({required this.dio});

  Future<List<Category>> fetchCategories(String token) async {
    final response = await dio.get(
      'https://dev.api.sapp.imaninvest.com/v1/categories',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['list'];
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
