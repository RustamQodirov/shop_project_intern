import 'package:dio/dio.dart';
import '../model/store_model.dart';

class StoreDataSource {
  final Dio dio;

  StoreDataSource({required this.dio});

  Future<List<Store>> fetchStores(String token) async {
    try {
      final response = await dio.get(
        'https://dev.api.sapp.imaninvest.com/v1/merchants/branches?limit=1000', // Replace with the actual endpoint
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response.data['data']['list'];
        return (data as List).map((e) => Store.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load stores');
      }
    } catch (e) {
      throw Exception('Error fetching stores: $e');
    }
  }
}
