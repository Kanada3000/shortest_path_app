import 'point.dart';
import 'task.dart';

class PathfindResult {
  final Task task;
  final List<Point> path;

  const PathfindResult({required this.task, required this.path});

  String get pathToString => path.map((p) => p.toString()).join("->");
}
