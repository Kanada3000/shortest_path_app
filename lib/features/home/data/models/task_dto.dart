import 'point_dto.dart';

class TaskDto {
  final String? id;
  final List<String>? field;
  final PointDto? start;
  final PointDto? end;

  TaskDto({this.id, this.field, this.start, this.end});

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      id: json['id'] as String?,
      field: List<String>.from(json['field']),
      start: PointDto.fromJson(json['start']),
      end: PointDto.fromJson(json['end']),
    );
  }
}
