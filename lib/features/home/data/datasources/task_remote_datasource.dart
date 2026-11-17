import 'dart:convert';
import 'dart:io';

import '../models/response_dto.dart';

abstract class TaskRemoteDataSource {
  Future<ResponseDto> fetchData();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final String baseUrl = "https://flutter.webspark.dev";

  @override
  Future<ResponseDto> fetchData() async {
    final client = HttpClient();
    final Uri uri = Uri.parse("$baseUrl/flutter/api");
    try {
      final request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        return ResponseDto.fromJson(jsonDecode(responseBody));
      } else {
        throw HttpException("Network error: ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
