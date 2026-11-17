class PointDto {
  final int? x;
  final int? y;

  PointDto({this.x, this.y});

  factory PointDto.fromJson(Map<String, dynamic> json) {
    return PointDto(x: json['x'] as int?, y: json['y'] as int?);
  }
}
