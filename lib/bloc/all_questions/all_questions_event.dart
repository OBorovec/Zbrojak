part of 'all_questions_bloc.dart';

abstract class AllQuestionsEvent extends Equatable {
  const AllQuestionsEvent();

  @override
  List<Object> get props => [];
}

class LoadQuestions extends AllQuestionsEvent {}

class QuestionIndexChanged extends AllQuestionsEvent {
  final int index;

  const QuestionIndexChanged({required this.index});

  @override
  List<Object> get props => [index];
}
