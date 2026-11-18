import 'point.dart';
import 'task.dart';

class PathfindResult {
  final Task task;
  final List<Point> path;

  const PathfindResult({required this.task, required this.path});

  String get pathToString => path.map((p) => p.toString()).join("->");

  /// Field with symbols of point.
  /// 'X' is block, '.' is empty tile, 'S' is start point, 'E' is end point and 'O' is the shortest path from start to end.
  List<List<String>> get fieldWithPath {
    final newField = task.field.map((r) => r.split('')).toList();
    final [start, ...other, end] = path;
    newField[start.y][start.x] = 'S';
    newField[end.y][end.x] = 'E';
    for (final p in other) {
      newField[p.y][p.x] = 'O';
    }
    return newField;
  }
}
