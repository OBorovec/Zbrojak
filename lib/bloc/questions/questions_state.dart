part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsLoading extends QuestionsState {
  final String? message;

  const QuestionsLoading({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;
  final int initIndex;

  const QuestionsLoaded({
    required this.questions,
    required this.initIndex,
  });

  @override
  List<Object> get props => [questions];
}
