import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/features/home/data/models/task_dto.dart';

void main() {
  group('TaskDto.fromJson', () {
    test('Json to TaskDto', () {
      final json = {
        'id': 'test-id',
        'field': ['.X.', 'X..', '.X.'],
        'start': {'x': 2, 'y': 0},
        'end': {'x': 0, 'y': 2},
      };

      final dto = TaskDto.fromJson(json);

      expect(dto, isNotNull);
      expect(dto.id, 'test-id');
      expect(dto.field, const ['.X.', 'X..', '.X.']);
      expect(dto.start?.x, 2);
      expect(dto.start?.y, 0);
      expect(dto.end?.x, 0);
      expect(dto.end?.y, 2);
    });

    test('Negative: Json with null fields to TaskDto', () {
      final json = {
        'id': null,
        'field': null,
        'start': null,
        'end': null,
      };

      final dto = TaskDto.fromJson(json);

      expect(dto, isNotNull);
      expect(dto.id, isNull);
      expect(dto.field, isNull);
      expect(dto.start, isNull);
      expect(dto.end, isNull);
    });

    test('Negative: empty Json to TaskDto', () {
      final dto = TaskDto.fromJson({});

      expect(dto, isNotNull);
      expect(dto.id, isNull);
      expect(dto.field, isNull);
      expect(dto.start, isNull);
      expect(dto.end, isNull);
    });
  });
}
