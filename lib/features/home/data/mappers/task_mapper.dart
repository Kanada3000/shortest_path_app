import '../../domain/entities/point.dart';
import '../../domain/entities/task.dart';
import '../models/task_dto.dart';
import 'point_mapper.dart';

extension TaskMapper on TaskDto {
  Task? toDomain() {
    return Task(
      id: id!,
      field: field ?? ([] as List<String>),
      start: start?.toDomain() ?? const Point(x: 0, y: 0),
      end: end?.toDomain() ?? const Point(x: 0, y: 0),
    );
  }
}
