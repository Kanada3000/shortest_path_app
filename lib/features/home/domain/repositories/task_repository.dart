import '../entities/pathfind_result.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> checkTasks(List<PathfindResult> results);
}
