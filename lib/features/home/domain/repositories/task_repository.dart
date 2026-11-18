import '../entities/answer.dart';
import '../entities/pathfind_result.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  void setUrl(String url);
  Future<List<Task>> getTasks();
  Future<List<Answer>> checkTasks(List<PathfindResult> results);
}
