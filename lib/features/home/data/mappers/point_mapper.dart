import '../../domain/entities/point.dart';
import '../models/point_dto.dart';

extension PointMapper on PointDto {
  Point toDomain() => Point(x: x ?? 0, y: y ?? 0);
}
