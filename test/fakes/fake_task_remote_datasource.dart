import 'package:shortest_path_app/features/home/data/datasources/task_remote_datasource.dart';
import 'package:shortest_path_app/features/home/data/models/answer_dto.dart';
import 'package:shortest_path_app/features/home/data/models/response_dto.dart';
import 'package:shortest_path_app/features/home/data/models/task_dto.dart';

class FakeTaskRemoteDatasource implements TaskRemoteDataSource {
  @override
  String baseUrl = "";

  ResponseDto<TaskDto>? fetchTask;
  ResponseDto<AnswerDto>? fetchAnswer;
  Object? error;

  List<Map<String, dynamic>>? sentJson;

  @override
  Future<ResponseDto<TaskDto>> fetchData() async {
    if (error != null) throw error!;
    return fetchTask!;
  }

  @override
  Future<ResponseDto<AnswerDto>> postData(
    List<Map<String, dynamic>> json,
  ) async {
    sentJson = json;
    if (error != null) throw error!;
    return fetchAnswer!;
  }
}
