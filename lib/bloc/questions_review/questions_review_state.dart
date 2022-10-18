part of 'questions_review_bloc.dart';

abstract class QuestionsReviewState extends Equatable {
  const QuestionsReviewState();

  @override
  List<Object> get props => [];
}

class QuestionsReviewLoading extends QuestionsReviewState {
  final String? message;

  const QuestionsReviewLoading({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class QuestionsReviewLoaded extends QuestionsReviewState {
  final List<Question> questions;
  final int idx;

  const QuestionsReviewLoaded({
    required this.questions,
    required this.idx,
  });

  @override
  List<Object> get props => [questions, idx];

  QuestionsReviewLoaded copyWith({
    List<Question>? questions,
    int? idx,
  }) {
    return QuestionsReviewLoaded(
      questions: questions ?? this.questions,
      idx: idx ?? this.idx,
    );
  }
}
