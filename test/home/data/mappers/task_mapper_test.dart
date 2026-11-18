import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/features/home/data/mappers/task_mapper.dart';
import 'package:shortest_path_app/features/home/data/models/point_dto.dart';
import 'package:shortest_path_app/features/home/data/models/task_dto.dart';

void main() {
  group('TaskMapper.toDomain', () {
    test('TaskDto to Task', () {
      const dto = TaskDto(
        id: 'task-111',
        field: ['..X', 'X..', '...'],
        start: PointDto(x: 0, y: 1),
        end: PointDto(x: 2, y: 0),
      );

      final domain = dto.toDomain();

      expect(domain, isNotNull);
      expect(domain!.id, 'task-111');
      expect(domain.field, const ['..X', 'X..', '...']);
      expect(domain.start.x, 0);
      expect(domain.start.y, 1);
      expect(domain.end.x, 2);
      expect(domain.end.y, 0);
    });

    test('id null', () {
      const dto = TaskDto(
        id: null,
        field: ['..X', 'X..', '...'],
        start: PointDto(x: 0, y: 1),
        end: PointDto(x: 2, y: 0),
      );

      final domain = dto.toDomain();

      expect(domain, isNull);
    });

    test('start and end points are null', () {
      const dto = TaskDto(
        id: 'task-111',
        field: ['..X', 'X..', '...'],
        start: null,
        end: null,
      );

      final domain = dto.toDomain();

      expect(domain, isNotNull);
      expect(domain!.id, 'task-111');
      expect(domain.field, const ['..X', 'X..', '...']);
      expect(domain.start.x, 0);
      expect(domain.start.y, 0);
      expect(domain.end.x, 0);
      expect(domain.end.y, 0);
    });

    test('field is null', () {
      const dto = TaskDto(
        id: 'task-111',
        field: null,
        start: PointDto(x: 0, y: 1),
        end: PointDto(x: 2, y: 0),
      );

      final domain = dto.toDomain();

      expect(domain, isNotNull);
      expect(domain!.id, 'task-111');
      expect(domain.field, isEmpty);
      expect(domain.start.x, 0);
      expect(domain.start.y, 1);
      expect(domain.end.x, 2);
      expect(domain.end.y, 0);
    });
  });
}
