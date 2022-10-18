part of 'questions_review_bloc.dart';

abstract class IncQuestionsEvent extends Equatable {
  const IncQuestionsEvent();

  @override
  List<Object> get props => [];
}

class LoadQuestionsReview extends IncQuestionsEvent {
  const LoadQuestionsReview();
}

class RemoveQuestionFromReview extends IncQuestionsEvent {
  const RemoveQuestionFromReview();
}

class QuestionsReviewIndexChanged extends IncQuestionsEvent {
  final int index;

  const QuestionsReviewIndexChanged({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}
