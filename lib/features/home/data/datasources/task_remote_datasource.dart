import 'dart:convert';
import 'dart:io';

import '../models/answer_dto.dart';
import '../models/task_dto.dart';
import '../models/response_dto.dart';

abstract class TaskRemoteDataSource {
  String baseUrl = "";
  Future<ResponseDto<TaskDto>> fetchData();
  Future<ResponseDto<AnswerDto>> postData(List<Map<String, dynamic>> json);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  @override
  String baseUrl = "";

  @override
  Future<ResponseDto<TaskDto>> fetchData() async {
    final client = HttpClient();
    final Uri uri = Uri.parse(baseUrl);
    try {
      final request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        return ResponseDto<TaskDto>.fromJson(
          jsonDecode(responseBody),
          TaskDto.fromJson,
        );
      } else {
        throw HttpException("Network error: ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<ResponseDto<AnswerDto>> postData(
    List<Map<String, dynamic>> json,
  ) async {
    final client = HttpClient();
    final Uri uri = Uri.parse(baseUrl);
    try {
      final request = await client.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.headers.set(HttpHeaders.acceptHeader, "application/json");

      final jsonBody = jsonEncode(json);
      request.write(jsonBody);

      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        return ResponseDto<AnswerDto>.fromJson(
          jsonDecode(responseBody),
          AnswerDto.fromJson,
        );
      } else {
        throw HttpException("Network error: ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
