import 'package:dio/dio.dart';
import 'package:shop/features/investment/home/data/model/tariff_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String bearerToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjI3MzkzNjgzODAsImlkIjoiZmQzODQ1NDMtYTIxMi00OWIyLWFlNjMtNTEyZWZkNjkyMDdlIiwidXNlcl9pZCI6IjU5NzA1ODdkLTEzNDMtNDM4ZC04NjI4LTZlZWViYjAzYmU2OSJ9.c3o5iPcWqP-Ce5aNWEvlkcpIwoO5IwWPUaM2RAg8cKw';

  ApiService() {
    _dio.options.headers["Authorization"] = "Bearer $bearerToken";
  }

  Future<List<Tariff>> fetchTariffs() async {
    final response =
        await _dio.get('https://dev.api.sapp.imaninvest.com/v1/invest/tariffs');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => Tariff.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tariffs');
    }
  }
}
