import '../../domain/entities/answer.dart';
import '../../domain/entities/pathfind_result.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../mappers/answer_mapper.dart';
import '../datasources/task_remote_datasource.dart';
import '../mappers/task_mapper.dart';
import '../mappers/pathfind_result_mapper.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  void setUrl(String url) {
    taskRemoteDataSource.baseUrl = url.trim();
  }

  @override
  Future<List<Task>> getTasks() async {
    try {
      final response = await taskRemoteDataSource.fetchData();

      if (response.error == true) {
        throw Exception("Error: ${response.message}");
      }

      final tasks = response.data ?? [];
      return tasks.map((dto) => dto.toDomain()).whereType<Task>().toList();
    } catch (e) {
      throw Exception("Could not load task: $e");
    }
  }

  @override
  Future<List<Answer>> checkTasks(List<PathfindResult> results) async {
    try {
      final json = results.map((r) => r.toDto().toJson()).toList();
      final response = await taskRemoteDataSource.postData(json);

      if (response.error == true) {
        throw Exception("Error: ${response.message}");
      }

      final answers = response.data ?? [];
      return answers.map((dto) => dto.toDomain()).whereType<Answer>().toList();
    } catch (e) {
      throw Exception("Could not check task: $e");
    }
  }
}
