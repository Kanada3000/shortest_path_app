import 'point_dto.dart';

class TaskDto {
  final String? id;
  final List<String>? field;
  final PointDto? start;
  final PointDto? end;

  const TaskDto({this.id, this.field, this.start, this.end});

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      id: json['id'] as String?,
      field: json['field'] != null ? List<String>.from(json['field']) : null,
      start: json['start'] != null ? PointDto.fromJson(json['start']) : null,
      end: json['end'] != null ? PointDto.fromJson(json['end']) : null,
    );
  }
}
