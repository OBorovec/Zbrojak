part of 'quick_test_bloc.dart';

enum QuickTestStatus { loading, running, finished, reviewing }

class QuickTestState extends Equatable {
  final QuickTestStatus status;
  final String? message;
  // Test setup
  final List<Question> questionsOrig;
  final List<Question> questions;
  // Test stats
  final int correctCount;
  final int mistakeCount;
  // Test review
  final List<Question> answers;

  const QuickTestState({
    this.status = QuickTestStatus.loading,
    this.message,
    this.questionsOrig = const [],
    this.questions = const [],
    this.correctCount = 0,
    this.mistakeCount = 0,
    this.answers = const [],
  });
  @override
  List<Object> get props => [
        status,
        message ?? '',
        questionsOrig,
        questions,
        correctCount,
        mistakeCount,
        answers,
      ];

  QuickTestState copyWith({
    QuickTestStatus? status,
    String? message,
    List<Question>? questionsOrig,
    List<Question>? questions,
    int? correctCount,
    int? mistakeCount,
    List<Question>? answers,
  }) {
    return QuickTestState(
      status: status ?? this.status,
      message: message ?? this.message,
      questionsOrig: questionsOrig ?? this.questionsOrig,
      questions: questions ?? this.questions,
      correctCount: correctCount ?? this.correctCount,
      mistakeCount: mistakeCount ?? this.mistakeCount,
      answers: answers ?? this.answers,
    );
  }
}
