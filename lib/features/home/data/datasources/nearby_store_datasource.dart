import 'package:dio/dio.dart';
import '../model/nearby_store_model.dart';

class NearbyStoreDataSource {
  final Dio dio;

  NearbyStoreDataSource({required this.dio});

  Future<NearbyStoreList> fetchNearbyStores(String token) async {
    final response = await dio.get(
      'https://dev.api.sapp.imaninvest.com/v1/merchants/branches',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return NearbyStoreList.fromJson(response.data);
    } else {
      throw Exception('Failed to load nearby stores');
    }
  }
}
