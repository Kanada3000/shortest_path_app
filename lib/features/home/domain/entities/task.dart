import 'point.dart';

class Task {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });
}
