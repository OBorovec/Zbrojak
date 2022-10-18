// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      question: json['question'] as String,
      image: json['image'] as String?,
      options: Map<String, String>.from(json['options'] as Map),
      correct: json['correct'] as String,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'image': instance.image,
      'options': instance.options,
      'correct': instance.correct,
      'answer': instance.answer,
    };
