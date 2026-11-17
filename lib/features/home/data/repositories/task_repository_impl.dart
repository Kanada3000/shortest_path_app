import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_datasource.dart';
import '../mappers/task_mapper.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  Future<List<Task>> getTasks() async {
    try {
      final response = await taskRemoteDataSource.fetchData();

      if (response.error == true) {
        // TODO: handle errors
      }

      final tasks = response.data ?? [];
      final test = tasks
          .map((dto) => dto.toDomain())
          .whereType<Task>()
          .toList();
      return test;
    } catch (e) {
      throw Exception("Could not load task: $e");
    }
  }
}
