import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/features/home/data/models/answer_dto.dart';
import 'package:shortest_path_app/features/home/data/models/point_dto.dart';
import 'package:shortest_path_app/features/home/data/models/response_dto.dart';
import 'package:shortest_path_app/features/home/data/models/task_dto.dart';
import 'package:shortest_path_app/features/home/data/repositories/task_repository_impl.dart';
import 'package:shortest_path_app/features/home/domain/entities/pathfind_result.dart';
import 'package:shortest_path_app/features/home/domain/entities/point.dart';
import 'package:shortest_path_app/features/home/domain/entities/task.dart';

import '../../../fakes/fake_task_remote_datasource.dart';

void main() {
  late FakeTaskRemoteDatasource fakeTaskRemoteDatasource;
  late TaskRepositoryImpl repo;

  setUp(() {
    fakeTaskRemoteDatasource = FakeTaskRemoteDatasource();
    repo = TaskRepositoryImpl(fakeTaskRemoteDatasource);
  });

  group('TaskRepositoryImpl.setUrl', () {
    test('valid url', () {
      const url = "https://flutter.webspark.dev";

      repo.setUrl(url);
      expect(fakeTaskRemoteDatasource.baseUrl, url);
    });

    test('url with spaces', () {
      const url = "     https://flutter.webspark.dev     ";

      repo.setUrl(url);
      expect(fakeTaskRemoteDatasource.baseUrl, "https://flutter.webspark.dev");
    });
  });

  group('TaskRepositoryImpl.getTasks', () {
    final validTask = TaskDto(
      id: 'task-111',
      field: ['..X', 'X..', '...'],
      start: PointDto(x: 0, y: 1),
      end: PointDto(x: 2, y: 0),
    );

    test('return task list', () async {
      fakeTaskRemoteDatasource.fetchTask = ResponseDto(
        error: false,
        message: 'OK',
        data: [validTask],
      );

      final tasksResponse = await repo.getTasks();

      expect(tasksResponse.length, 1);
      expect(tasksResponse.first.id, 'task-111');
    });

    test('task list without task with id null', () async {
      fakeTaskRemoteDatasource.fetchTask = ResponseDto(
        error: false,
        message: 'OK',
        data: [validTask, TaskDto(id: null)],
      );

      final tasksResponse = await repo.getTasks();

      expect(tasksResponse.length, 1);
      expect(tasksResponse.first.id, 'task-111');
    });

    test('empty list if data is null', () async {
      fakeTaskRemoteDatasource.fetchTask = ResponseDto(
        error: false,
        message: 'OK',
        data: null,
      );

      final tasksResponse = await repo.getTasks();

      expect(tasksResponse, isEmpty);
    });

    test('throws exception if error=true', () async {
      fakeTaskRemoteDatasource.fetchTask = ResponseDto(
        error: true,
        message: 'Invalid request',
        data: null,
      );

      await expectLater(
        repo.getTasks(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Invalid request'),
          ),
        ),
      );
    });

    test('throws exception on dataSource error', () async {
      fakeTaskRemoteDatasource.error = Exception('DataSource exception');

      await expectLater(
        repo.getTasks(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('DataSource exception'),
          ),
        ),
      );
    });
  });

  group('TaskRepositoryImpl.checkTasks', () {
    final result = [
      PathfindResult(
        task: Task(
          id: 'task-111',
          field: ['..', '..'],
          start: const Point(x: 0, y: 0),
          end: const Point(x: 1, y: 1),
        ),
        path: const [Point(x: 0, y: 0), Point(x: 1, y: 1)],
      ),
    ];

    test('valid json receives', () async {
      fakeTaskRemoteDatasource.fetchAnswer = ResponseDto(
        error: false,
        message: 'OK',
        data: [AnswerDto(id: 'task-111', correct: true)],
      );

      final answers = await repo.checkTasks(result);

      expect(answers.length, 1);
      expect(answers.first.id, 'task-111');
      expect(answers.first.correct, isTrue);
    });

    test('throws exception if error=true', () async {
      fakeTaskRemoteDatasource.fetchAnswer = ResponseDto(
        error: true,
        message: 'Invalid request',
        data: null,
      );

      await expectLater(
        repo.checkTasks(result),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Invalid request'),
          ),
        ),
      );
    });

    test('throws exception on dataSource error', () async {
      fakeTaskRemoteDatasource.error = Exception('DataSource exception');

      await expectLater(
        repo.checkTasks(result),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('DataSource exception'),
          ),
        ),
      );
    });
  });
}
