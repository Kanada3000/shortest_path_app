class Point {
  final int x;
  final int y;

  const Point({required this.x, required this.y});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && other.x == x && other.y == y;
  }

  Point operator +(Point other) {
    return Point(x: x + other.x, y: y + other.y);
  }

  /// Returns true if equals to Point(0,0).
  bool get isZero => x == 0 && y == 0;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() {
    return "Point($x, $y)";
  }
}
