import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String question;
  final String answer;
  final List<String> options;
  final String? image;

  const Question({
    required this.question,
    required this.answer,
    required this.options,
    this.image,
  });

  @override
  List<Object> get props => [
        question,
        answer,
        options,
      ];

  Question copyWith({
    String? question,
    String? answer,
    List<String>? options,
    String? image,
  }) {
    return Question(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      options: options ?? this.options,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'options': options,
      'image': image,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
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
    return 'Question(question: $question, answer: $answer, options: $options, image: $image)';
  }
}
