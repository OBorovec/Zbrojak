part of 'quick_test_bloc.dart';

abstract class QuickTestEvent extends Equatable {
  const QuickTestEvent();

  @override
  List<Object> get props => [];
}

class LoadQuickTest extends QuickTestEvent {
  const LoadQuickTest();
}

class NewQuickTest extends QuickTestEvent {
  const NewQuickTest();
}

class RepeatQuickTest extends QuickTestEvent {
  const RepeatQuickTest();
}

class AnswerQuickQuestion extends QuickTestEvent {
  final String answer;

  const AnswerQuickQuestion({
    required this.answer,
  });

  @override
  List<Object> get props => [answer];
}

class QuickTestReview extends QuickTestEvent {
  const QuickTestReview();
}
