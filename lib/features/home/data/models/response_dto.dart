class ResponseDto<T> {
  final bool? error;
  final String? message;
  final List<T>? data;

  ResponseDto({this.error, this.message, this.data});

  factory ResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    final rawData = json['data'] as List<dynamic>?;
    return ResponseDto<T>(
      error: json['error'],
      message: json['message'],
      data: rawData
          ?.map(
            (j) => fromJsonT(j as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
