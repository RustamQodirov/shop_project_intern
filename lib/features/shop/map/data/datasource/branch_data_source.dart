import 'package:dio/dio.dart';
import '../models/branch_model.dart';

class BranchDataSource {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://dev.api.sapp.imaninvest.com/v1/merchants/branches?limit=1000';
  final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE4OTc0Njg4ODgsImlkIjoiYmFjYWZlZTUtYWI4MC00NjBmLWIwODgtNjFhNDJmZmZjMGFlIiwidXNlcl9pZCI6IjU5NzA1ODdkLTEzNDMtNDM4ZC04NjI4LTZlZWViYjAzYmU2OSJ9.Mjc1j9lu12lc2eNddzeKi7z8GB1zu95uXi5gSOC0mKs';

  Future<List<Branch>> fetchBranches() async {
    try {
      final response = await _dio.get(_baseUrl, options: Options(
          headers: {'Authorization': 'Bearer $_token'}
      ));
      final List<dynamic> data = response.data['data']['list'];
      return data.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load branches');
    }
  }
}