import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/features/home/domain/entities/pathfind_result.dart';
import 'package:shortest_path_app/features/home/domain/entities/point.dart';
import 'package:shortest_path_app/features/home/domain/entities/task.dart';
import 'package:shortest_path_app/features/results/presentation/screens/preview_screen.dart';

void main() {
  const startColor = Color(0xFF64FFDA);
  const endColor = Color(0xFF009688);
  const pathColor = Color(0xFF4CAF50);
  const blockedColor = Color(0xFF000000);
  const defaultColor = Color(0xFFFFFFFF);

  PathfindResult result = const PathfindResult(
    task: Task(
      id: 'test-111',
      field: [
        '..X',
        'X..',
        'X..',
      ],
      start: Point(x: 0, y: 0),
      end: Point(x: 1, y: 2),
    ),
    path: [
      Point(x: 0, y: 0),
      Point(x: 1, y: 1),
      Point(x: 1, y: 2),
    ],
  );

  Color? tileColor(WidgetTester tester, int x, int y) {
    final box = tester.widget<DecoratedBox>(
      find
          .ancestor(
            of: find.text('($x,$y)'),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    return (box.decoration as BoxDecoration).color;
  }

  Future<void> buildTestApp(
    WidgetTester tester,
    PathfindResult result,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(home: PreviewScreen(result: result)));
  }

  group('Preview Screen', () {
    testWidgets('string path exists', (tester) async {
      await buildTestApp(tester, result);

      expect(find.text('(0,0)->(1,1)->(1,2)'), findsOne);
    });

    testWidgets('Has all tiles with coordinates', (tester) async {
      await buildTestApp(tester, result);

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          expect(find.text('($i,$j)'), findsOneWidget);
        }
      }
    });

    testWidgets('Has correct colors', (tester) async {
      await buildTestApp(tester, result);

      expect(tileColor(tester, 1, 0), defaultColor);
      expect(tileColor(tester, 2, 0), blockedColor);
      expect(tileColor(tester, 0, 0), startColor);
      expect(tileColor(tester, 1, 2), endColor);
      expect(tileColor(tester, 1, 1), pathColor);
    });

    testWidgets('White text on blocked tile', (tester) async {
      await buildTestApp(tester, result);

      final text = tester.widget<Text>(find.text('(0,1)'));
      expect(text.style?.color, Colors.white);
    });

    testWidgets('Black text on white tile', (tester) async {
      await buildTestApp(tester, result);

      final text = tester.widget<Text>(find.text('(2,2)'));
      expect(text.style?.color, Colors.black);
    });
  });
}
