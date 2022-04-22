part of 'incorrect_questions_bloc.dart';

abstract class IncQuestionsState extends Equatable {
  const IncQuestionsState();

  @override
  List<Object> get props => [];
}

class IncQuestionsLoading extends IncQuestionsState {
  final String? message;

  const IncQuestionsLoading({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class IncQuestionsLoaded extends IncQuestionsState {
  final List<Question> questions;
  final int idx;

  const IncQuestionsLoaded({
    required this.questions,
    required this.idx,
  });

  @override
  List<Object> get props => [questions, idx];

  IncQuestionsLoaded copyWith({
    List<Question>? questions,
    int? idx,
  }) {
    return IncQuestionsLoaded(
      questions: questions ?? this.questions,
      idx: idx ?? this.idx,
    );
  }
}
