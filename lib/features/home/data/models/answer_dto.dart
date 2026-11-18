class AnswerDto {
  final String? id;
  final bool? correct;

  AnswerDto({this.id, this.correct});

  factory AnswerDto.fromJson(Map<String, dynamic> json) {
    return AnswerDto(id: json['id'], correct: json['correct']);
  }
}
