import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/features/home/presentation/providers/repository_scope.dart';
import 'package:shortest_path_app/features/home/presentation/screens/home_screen.dart';
import 'package:shortest_path_app/features/home/presentation/screens/process_screen.dart';

import '../../../fakes/fake_task_repository.dart';

void main() {
  late FakeTaskRepository fakeRepo;

  setUp(() {
    fakeRepo = FakeTaskRepository();
  });

  Widget buildTestApp() {
    return RepositoryScope(
      taskRepository: fakeRepo,
      child: const MaterialApp(home: HomeScreen()),
    );
  }

  Future<void> enterUrlAndSubmit(WidgetTester tester, String url) async {
    await tester.enterText(find.byType(TextFormField), url);
    await tester.tap(find.text('Start counting process'));
    await tester.pump();
  }

  group('Home Screen', () {
    testWidgets('Show default url', (tester) async {
      await tester.pumpWidget(buildTestApp());

      expect(
        find.text('https://flutter.webspark.dev/flutter/api'),
        findsOneWidget,
      );
    });

    testWidgets('enter valid url', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await enterUrlAndSubmit(
        tester,
        'https://flutter.webspark.dev/flutter/api',
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(ProcessScreen), findsOneWidget);
      expect(fakeRepo.lastUrl, 'https://flutter.webspark.dev/flutter/api');
    });

    testWidgets('error if empty url', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await enterUrlAndSubmit(tester, "");

      expect(find.text('Enter URL'), findsOneWidget);
      expect(find.byType(ProcessScreen), findsNothing);
      expect(fakeRepo.lastUrl, isNull);
    });

    testWidgets('error if invalid url', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await enterUrlAndSubmit(tester, "acb");

      expect(find.text('Enter valid URL'), findsOneWidget);
      expect(find.byType(ProcessScreen), findsNothing);
      expect(fakeRepo.lastUrl, isNull);
    });
  });
}
