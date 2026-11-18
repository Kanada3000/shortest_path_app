import 'dart:math';

import '../entities/point.dart';

/// sqrt(2) ~ 1,4142135623
const double _diagonalCost = sqrt2;

class AStarPathFinder {
  static List<Point> findShortestPath({
    required List<String> stringField,
    required Point start,
    required Point end,
  }) {
    final field = _stringFieldToInt(stringField);
    if (!_valid(field, start, end)) return [];

    // start
    final openSet = Set<_Node>.from({});
    final closedSet = Set<_Node>.from({});
    final allNodes = Map<Point, _Node>.from({});
    const directions = [
      Point(x: 0, y: 1),
      Point(x: 1, y: 1),
      Point(x: 1, y: 0),
      Point(x: 1, y: -1),
      Point(x: 0, y: -1),
      Point(x: -1, y: -1),
      Point(x: -1, y: 0),
      Point(x: -1, y: 1),
    ];

    final startNode = _Node(point: start);
    final endNode = _Node(point: end);

    startNode.hCost = _calculateOctileHeuristic(startNode, endNode);

    openSet.add(startNode);
    allNodes[start] = startNode;

    while (openSet.isNotEmpty) {
      final current = openSet.first;
      openSet.remove(current);

      if (current == endNode) return _buildPath(current);
      closedSet.add(current);

      for (Point direction in directions) {
        final newPoint = current.point + direction;

        if (_outOfBoundsOrBarrier(field, newPoint)) {
          continue;
        }

        _Node neighbor = allNodes.putIfAbsent(
          newPoint,
          () => _Node(point: newPoint),
        );
        if (closedSet.contains(neighbor)) {
          continue;
        }

        final stepCost = direction.isZero ? _diagonalCost : 1.0;
        final newGCost = current.gCost + stepCost;

        if (!openSet.contains(neighbor) || newGCost < neighbor.gCost) {
          neighbor
            ..parent = current
            ..gCost = newGCost
            ..hCost = _calculateOctileHeuristic(neighbor, endNode);

          openSet.remove(neighbor);
          openSet.add(neighbor);
        }
      }
    }
    return [];
  }

  static List<List<int>> _stringFieldToInt(List<String> field) => field
      .map(
        (row) => row.split('').map((symbol) => symbol == 'X' ? 1 : 0).toList(),
      )
      .toList();

  static double _calculateOctileHeuristic(_Node a, _Node b) {
    final dx = (a.point.x - b.point.x).abs();
    final dy = (a.point.y - b.point.y).abs();
    return dx + dy + (_diagonalCost - 2) * min(dx, dy);
  }

  static List<Point> _buildPath(_Node? node) {
    final path = <_Node>[];
    while (node != null) {
      path.add(node);
      node = node.parent;
    }
    return path.reversed.map((n) => n.point).toList();
  }

  static bool _outOfBoundsOrBarrier(List<List<int>> field, Point point) {
    return point.x < 0 ||
        point.x >= field[0].length ||
        point.y < 0 ||
        point.y >= field.length ||
        field[point.y][point.x] == 1;
  }

  static bool _valid(List<List<int>> field, Point start, Point end) {
    if (field.isEmpty || field[0].isEmpty) return false;
    if (_outOfBoundsOrBarrier(field, start) ||
        _outOfBoundsOrBarrier(field, end)) {
      return false;
    }
    return true;
  }
}

class _Node {
  final Point point;
  double gCost;
  double hCost;
  _Node? parent;

  _Node({required this.point}) : parent = null, hCost = 0, gCost = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _Node && other.point == point;
  }

  @override
  int get hashCode => Object.hash(point, gCost, hCost, parent);
}
