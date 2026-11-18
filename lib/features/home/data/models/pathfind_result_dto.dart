import 'package:shortest_path_app/features/home/data/models/point_dto.dart';

class PathfindResultDto {
  final String? id;
  final List<PointDto>? steps;
  final String? path;

  PathfindResultDto({this.id, this.steps, this.path});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': steps?.map((p) => p.toJson()).toList(),
        'path': path,
      },
    };
  }
}
