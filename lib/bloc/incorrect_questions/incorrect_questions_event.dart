part of 'incorrect_questions_bloc.dart';

abstract class IncQuestionsEvent extends Equatable {
  const IncQuestionsEvent();

  @override
  List<Object> get props => [];
}

class LoadIncQuestions extends IncQuestionsEvent {}

class RemoveCurrentIncQuestion extends IncQuestionsEvent {}

class IncQuestionIndexChanged extends IncQuestionsEvent {
  final int index;

  const IncQuestionIndexChanged({required this.index});

  @override
  List<Object> get props => [index];
}
