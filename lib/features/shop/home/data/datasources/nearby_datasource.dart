import 'package:dio/dio.dart';

import '../model/nearby_model.dart';

class NearbyDataSource {
  final Dio dio;

  NearbyDataSource({required this.dio});

  Future<List<NearbyStore>> fetchNearbyStores(String token) async {
    final response = await dio.get(
      'https://dev.api.sapp.imaninvest.com/v1/merchants/branches?limit=1000',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List data = response.data['data']['list'];
      return data.map((store) => NearbyStore.fromJson(store)).toList();
    } else {
      throw Exception('Failed to load nearby stores');
    }
  }
}
