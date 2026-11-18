import '../../domain/entities/point.dart';
import '../../domain/entities/task.dart';
import '../models/task_dto.dart';
import 'point_mapper.dart';

extension TaskMapper on TaskDto {
  Task? toDomain() {
    if (id == null) return null;
    return Task(
      id: id!,
      field: field ?? const <String>[],
      start: start?.toDomain() ?? const Point(x: 0, y: 0),
      end: end?.toDomain() ?? const Point(x: 0, y: 0),
    );
  }
}
