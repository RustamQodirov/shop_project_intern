import 'package:dio/dio.dart';

import '../model/banner_model.dart';


class BannerDataSource {
  final Dio dio;

  BannerDataSource({required this.dio});

  Future<List<BannerModel>> fetchBanners(String token) async {
    final response = await dio.get(
      'https://dev.api.sapp.imaninvest.com/v1/content/banners',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    if (response.statusCode == 200) {
      final List banners = response.data['data']['list'];
      return banners
          .map((banner) => BannerModel.fromJson(banner))
          .toList();
    } else {
      throw Exception('Failed to load banners');
    }
  }
}
