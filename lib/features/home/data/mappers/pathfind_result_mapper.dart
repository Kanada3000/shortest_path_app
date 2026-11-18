import 'package:shortest_path_app/features/home/data/mappers/point_mapper.dart';
import 'package:shortest_path_app/features/home/data/models/pathfind_result_dto.dart';

import '../../domain/entities/pathfind_result.dart';

extension PathfindResultMapper on PathfindResult {
  PathfindResultDto toDto() {
    return PathfindResultDto(
      id: task.id,
      steps: path.map((p) => p.toDto()).toList(),
      path: path.map((p) => p.toString()).join("->"),
    );
  }
}
