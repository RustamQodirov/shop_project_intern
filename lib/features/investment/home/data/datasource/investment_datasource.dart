import 'package:dio/dio.dart';
import 'package:shop/features/investment/home/data/model/investment_model.dart';

class InvestmentDataSource {
  final Dio dio;

  InvestmentDataSource(this.dio);

  Future<List<Investment>> fetchInvestments() async {
    final response = await dio.get(
      'https://dev.api.sapp.imaninvest.com/v1/invest/investments',
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjI3MzkzNjgzODAsImlkIjoiZmQzODQ1NDMtYTIxMi00OWIyLWFlNjMtNTEyZWZkNjkyMDdlIiwidXNlcl9pZCI6IjU5NzA1ODdkLTEzNDMtNDM4ZC04NjI4LTZlZWViYjAzYmU2OSJ9.c3o5iPcWqP-Ce5aNWEvlkcpIwoO5IwWPUaM2RAg8cKw'
        },
      ),
    );
    final data = response.data['data'] as List;
    return data.map((json) => Investment.fromJson(json)).toList();
  }
}
