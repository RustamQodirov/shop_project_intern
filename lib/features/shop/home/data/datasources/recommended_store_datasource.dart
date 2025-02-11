import 'package:dio/dio.dart';
import '../model/recommended_store_model.dart';

class RecommendedStoreDataSource {
  final Dio dio;

  RecommendedStoreDataSource({required this.dio});

  Future<List<RecommendedStore>> fetchRecommendedStores(String token) async {
    final response = await dio.get(
      'https://dev.api.sapp.imaninvest.com/v1/merchants/branches?limit=1000',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data['data']['list'] as List<dynamic>;
      return data.map((item) => RecommendedStore.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch recommended stores');
    }
  }
}
