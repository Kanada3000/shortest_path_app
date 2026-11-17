import 'task_dto.dart';

class ResponseDto {
  final bool? error;
  final String? message;
  final List<TaskDto>? data;

  ResponseDto({this.error, this.message, this.data});

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      error: json['error'],
      message: json['message'],
      data: List<TaskDto>.from(json['data']?.map((j) => TaskDto.fromJson(j))),
    );
  }
}
