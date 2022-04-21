import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int id;
  final String question;
  final String answer;
  final List<String> options;
  final String? image;

  const Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
    this.image,
  });

  @override
  List<Object> get props {
    return [id];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'options': options,
      'image': image,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      options: List<String>.from(map['options']),
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answer: $answer, options: $options, image: $image)';
  }
}
