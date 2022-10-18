part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class LoadQuestions extends QuestionsEvent {
  const LoadQuestions();
}

class QuestionIndexChanged extends QuestionsEvent {
  final int index;

  const QuestionIndexChanged({required this.index});

  @override
  List<Object> get props => [index];
}
