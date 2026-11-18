import '../../domain/entities/point.dart';
import '../models/point_dto.dart';

extension PointDtoMapper on PointDto {
  Point toDomain() => Point(x: x ?? 0, y: y ?? 0);
}

extension PointMapper on Point {
  PointDto toDto() => PointDto(x: x, y: y);
}
