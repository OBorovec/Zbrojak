part of 'simple_test_bloc.dart';

@immutable
abstract class SimpleTestEvent extends Equatable {}

class LoadSimpleTest extends SimpleTestEvent {
  @override
  List<Object?> get props => [];
}

class ResetSimpleTest extends SimpleTestEvent {
  @override
  List<Object?> get props => [];
}

class AnswerQuestion extends SimpleTestEvent {
  final String answer;

  AnswerQuestion({
    required this.answer,
  });
  @override
  List<Object?> get props => [answer];
}
