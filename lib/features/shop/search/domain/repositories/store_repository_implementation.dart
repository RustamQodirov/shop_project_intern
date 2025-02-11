import 'package:dio/dio.dart';

import '../../data/model/store_model.dart';

class StoreDataSource {
  final Dio dio;

  StoreDataSource({required this.dio});

  Future<List<Store>> fetchStores(String token) async {
    try {
      final response = await dio.get(
        'your_api_endpoint_here',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // Assuming the response contains a list of stores in the 'data' field
        List<dynamic> storeList = response.data['data'];
        return storeList.map((store) => Store.fromJson(store)).toList();
      } else {
        throw Exception('Failed to load stores');
      }
    } catch (e) {
      throw Exception('Error fetching stores: $e');
    }
  }
}
