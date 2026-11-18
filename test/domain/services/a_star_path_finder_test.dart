import 'package:flutter_test/flutter_test.dart';
import 'package:shortest_path_app/features/home/domain/entities/point.dart';
import 'package:shortest_path_app/features/home/domain/services/a_star_path_finder.dart';

void main() {
  group('AStarPathFinder.findShortestPath', () {
    test('Field 2x2', () {
      const field = [
        "..",
        "..",
      ];
      const start = Point(x: 0, y: 0);
      const end = Point(x: 1, y: 0);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const [Point(x: 0, y: 0), Point(x: 1, y: 0)]);
    });

    test('Field 99x99 and diagonal', () {
      final row = "." * 99;
      final field = List.filled(99, row);

      const start = Point(x: 0, y: 0);
      const end = Point(x: 98, y: 98);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, List.generate(99, (n) => Point(x: n, y: n)));
    });

    test('Start point equals end point', () {
      const field = [
        "...",
        "...",
        "...",
      ];
      const start = Point(x: 0, y: 2);
      const end = Point(x: 0, y: 2);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const [
        Point(x: 0, y: 2),
      ]);
    });

    test('Only diagonal path', () {
      const field = [
        "XX.",
        "X.X",
        ".XX",
      ];
      const start = Point(x: 0, y: 2);
      const end = Point(x: 2, y: 0);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const [
        Point(x: 0, y: 2),
        Point(x: 1, y: 1),
        Point(x: 2, y: 0),
      ]);
    });

    test('Start and finish not on the edges', () {
      const field = [
        ".....",
        ".....",
        ".....",
        ".....",
        ".....",
      ];
      const start = Point(x: 1, y: 2);
      const end = Point(x: 3, y: 3);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(
        path,
        anyOf(const [
          [
            Point(x: 1, y: 2),
            Point(x: 2, y: 2),
            Point(x: 3, y: 3),
          ],
          [
            Point(x: 1, y: 2),
            Point(x: 2, y: 3),
            Point(x: 3, y: 3),
          ],
        ]),
      );
    });

    test('From right to left', () {
      const field = [
        "...",
        "...",
        "...",
      ];
      const start = Point(x: 2, y: 0);
      const end = Point(x: 0, y: 2);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const [
        Point(x: 2, y: 0),
        Point(x: 1, y: 1),
        Point(x: 0, y: 2),
      ]);
    });

    test('Rectangle field', () {
      const fieldHorizontal = <String>[
        "...",
        "...",
      ];
      const startHorizontal = Point(x: 2, y: 0);
      const endHorizontal = Point(x: 0, y: 1);

      const fieldVertical = <String>[
        "..",
        "..",
        "..",
      ];
      const startVertical = Point(x: 1, y: 0);
      const endVertical = Point(x: 0, y: 2);

      final pathHorizontal = AStarPathFinder.findShortestPath(
        stringField: fieldHorizontal,
        start: startHorizontal,
        end: endHorizontal,
      );

      final pathVertical = AStarPathFinder.findShortestPath(
        stringField: fieldVertical,
        start: startVertical,
        end: endVertical,
      );

      expect(pathHorizontal, const [
        Point(x: 2, y: 0),
        Point(x: 1, y: 0),
        Point(x: 0, y: 1),
      ]);

      expect(pathVertical, const [
        Point(x: 1, y: 0),
        Point(x: 1, y: 1),
        Point(x: 0, y: 2),
      ]);
    });

    // Negatives
    test('Negative: empty field', () {
      const field = <String>[];
      const start = Point(x: 2, y: 0);
      const end = Point(x: 0, y: 2);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const []);
    });

    test('Negative: start or finish is located out of the field', () {
      const field = <String>[
        "..",
        "..",
      ];

      const startOut = Point(x: 2, y: 0);
      const startIn = Point(x: 1, y: 0);

      const endIn = Point(x: 1, y: 1);
      const endOut = Point(x: 0, y: 2);

      final pathCases = [
        [startIn, endOut],
        [startOut, endIn],
        [startOut, endOut],
      ];

      final pathes = pathCases
          .map(
            (p) => AStarPathFinder.findShortestPath(
              stringField: field,
              start: p[0],
              end: p[1],
            ),
          )
          .toList();

      expect(pathes, const [[], [], []]);
    });

    test('Negative: blocked field', () {
      const field = <String>[
        "XXX",
        "XXX",
        "XXX",
      ];
      const start = Point(x: 2, y: 0);
      const end = Point(x: 0, y: 2);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const []);
    });

    test('Negative: start or finish on blocked tile', () {
      const field = <String>[
        "..X",
        "...",
        "X..",
      ];

      const startBlocked = Point(x: 2, y: 0);
      const startEmpty = Point(x: 1, y: 0);

      const endEmpty = Point(x: 1, y: 1);
      const endBlocked = Point(x: 0, y: 2);

      final pathCases = [
        [startEmpty, endBlocked],
        [startBlocked, endEmpty],
        [startBlocked, endBlocked],
      ];

      final pathes = pathCases
          .map(
            (p) => AStarPathFinder.findShortestPath(
              stringField: field,
              start: p[0],
              end: p[1],
            ),
          )
          .toList();

      expect(pathes, const [[], [], []]);
    });

    test('Negative: no path', () {
      const field = <String>[
        "XX.",
        "XXX",
        ".XX",
      ];
      const start = Point(x: 2, y: 0);
      const end = Point(x: 0, y: 2);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const []);
    });

    test('Negative: negative coordinates', () {
      const field = [
        "...",
        "...",
        "...",
      ];
      const start = Point(x: -1, y: 2);
      const end = Point(x: 0, y: -2);

      final path = AStarPathFinder.findShortestPath(
        stringField: field,
        start: start,
        end: end,
      );

      expect(path, const []);
    });
  });
}
