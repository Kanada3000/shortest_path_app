class PointDto {
  final int? x;
  final int? y;

  const PointDto({this.x, this.y});

  factory PointDto.fromJson(Map<String, dynamic> json) {
    return PointDto(x: json['x'] as int?, y: json['y'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y};
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PointDto && other.x == x && other.y == y;
  }

  @override
  String toString() {
    return '($x,$y)';
  }

  @override
  int get hashCode => Object.hash(x, y);
}
