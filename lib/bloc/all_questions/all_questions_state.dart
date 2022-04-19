part of 'all_questions_bloc.dart';

abstract class AllQuestionsState extends Equatable {
  const AllQuestionsState();

  @override
  List<Object> get props => [];
}

class AllQuestionsLoading extends AllQuestionsState {
  final String? message;

  const AllQuestionsLoading({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class AllQuestionsLoaded extends AllQuestionsState {
  final List<Question> questions;
  final int initIndex;

  const AllQuestionsLoaded({
    required this.questions,
    required this.initIndex,
  });

  @override
  List<Object> get props => [questions];
}
