import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zbrojak/constants/setting.dart';
import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/assets_loader.dart';

part 'simple_test_event.dart';
part 'simple_test_state.dart';

class SimpleTestBloc extends Bloc<SimpleTestEvent, SimpleTestState> {
  late List<Question> availableQuestions;

  SimpleTestBloc() : super(SimpleTestLoading()) {
    on<LoadSimpleTest>(_loadSimpleTest);
    on<ResetSimpleTest>(_resetSimpleTest);
    on<AnswerQuestion>(_answerTestQuestion);
  }

  FutureOr<void> _loadSimpleTest(
    LoadSimpleTest event,
    Emitter<SimpleTestState> emit,
  ) async {
    try {
      // Load words of Set
      final List<dynamic> questionDataSet =
          await parseJsonFromAssets('assets/2021/questions.json')
              as List<dynamic>;
      availableQuestions = questionDataSet
          .map((e) => Question.fromMap(e))
          // .where((q) => q.image != null) // For Image based question testing
          .toList();
      add(ResetSimpleTest());
    } catch (e) {
      emit(SimpleTestLoading(message: e.toString()));
    }
  }

  FutureOr<void> _resetSimpleTest(
    ResetSimpleTest event,
    Emitter<SimpleTestState> emit,
  ) {
    availableQuestions.shuffle();
    final List<Question> questions =
        availableQuestions.sublist(0, Setting.simpleTestRounds).toList();
    // Emit state
    emit(
      SimpleTestRunning(
        questions: questions,
        index: 0,
        correctCount: 0,
        mistakeCount: 0,
      ),
    );
  }

  FutureOr<void> _answerTestQuestion(
    AnswerQuestion event,
    Emitter<SimpleTestState> emit,
  ) {
    if (state is SimpleTestRunning) {
      SimpleTestRunning strState = state as SimpleTestRunning;
      Question currectQ = strState.questions[strState.index];
      // Question answer evaluation
      late final int correct;
      late final int mistake;
      if (event.answer == currectQ.answer) {
        correct = 1;
        mistake = 0;
      } else {
        correct = 0;
        mistake = 1;
        // TODO: store mistake in user DB
      }
      if (strState.index + 1 == Setting.simpleTestRounds) {
        emit(
          strState.copyWith(
            status: TetsStatus.finished,
            correctCount: strState.correctCount + correct,
            mistakeCount: strState.mistakeCount + mistake,
          ),
        );
      } else {
        emit(
          strState.copyWith(
            index: strState.index + 1,
            correctCount: strState.correctCount + correct,
            mistakeCount: strState.mistakeCount + mistake,
          ),
        );
      }
    }
  }
}
