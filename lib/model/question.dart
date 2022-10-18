import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final int id;
  final String question;
  final String? image;
  final Map<String, String> options;
  final String correct;
  final String? answer;

  const Question({
    required this.id,
    required this.question,
    this.image,
    required this.options,
    required this.correct,
    this.answer,
  });

  @override
  List<Object> get props {
    return [id];
  }

  factory Question.fromJson(Map<String, Object?> json) =>
      _$QuestionFromJson(json);

  Map<String, Object?> toJson() => _$QuestionToJson(this);

  @override
  String toString() {
    return 'Question(id: $id)';
  }

  Question copyWith({
    int? id,
    String? question,
    String? image,
    Map<String, String>? options,
    String? correct,
    String? answer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      image: image ?? this.image,
      options: options ?? this.options,
      correct: correct ?? this.correct,
      answer: answer ?? this.answer,
    );
  }
}
