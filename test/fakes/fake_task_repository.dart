import 'package:shortest_path_app/features/home/domain/entities/answer.dart';
import 'package:shortest_path_app/features/home/domain/entities/pathfind_result.dart';
import 'package:shortest_path_app/features/home/domain/entities/task.dart';
import 'package:shortest_path_app/features/home/domain/repositories/task_repository.dart';

class FakeTaskRepository implements TaskRepository {
  String? lastUrl;

  @override
  void setUrl(String url) => lastUrl = url;

  @override
  Future<List<Task>> getTasks() async => [];

  @override
  Future<List<Answer>> checkTasks(List<PathfindResult> results) async => [];
}
