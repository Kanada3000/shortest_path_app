import 'package:shortest_path_app/features/home/data/models/answer_dto.dart';
import 'package:shortest_path_app/features/home/domain/entities/answer.dart';

extension AnswerMapper on AnswerDto {
  Answer toDomain() {
    return Answer(id: id!, correct: correct ?? false);
  }
}
