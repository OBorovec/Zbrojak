import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zbrojak/constants/setting.dart';
import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/prefs_repo.dart';

part 'quick_test_event.dart';
part 'quick_test_state.dart';

class QuickTestBloc extends Bloc<QuickTestEvent, QuickTestState> {
  final PrefsRepo _prefs;
  late List<Question> availableQuestions;

  QuickTestBloc({
    required PrefsRepo prefs,
  })  : _prefs = prefs,
        super(const QuickTestState()) {
    on<LoadQuickTest>(_onLoadQuickTest);
    on<NewQuickTest>(_onNewQuickTest);
    on<RepeatQuickTest>(_onRepeatQuickTest);
    on<AnswerQuickQuestion>(_onAnswerTestQuestion);
    on<QuickTestReview>(_onQuickTestReview);
    // Init
    add(const LoadQuickTest());
  }

  FutureOr<void> _onLoadQuickTest(
    LoadQuickTest event,
    Emitter<QuickTestState> emit,
  ) async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/2021/questions.json');
      final List<dynamic> data = await json.decode(jsonString);
      availableQuestions =
          data.map<Question>((json) => Question.fromJson(json)).toList();
      add(const NewQuickTest());
    } catch (e) {
      emit(QuickTestState(
        status: QuickTestStatus.loading,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onNewQuickTest(
    NewQuickTest event,
    Emitter<QuickTestState> emit,
  ) {
    availableQuestions.shuffle();
    final List<Question> questions =
        availableQuestions.sublist(0, Setting.quickTestRounds).toList();
    // Emit state
    emit(
      QuickTestState(
        status: QuickTestStatus.running,
        questionsOrig: questions,
        questions: List.from(questions),
      ),
    );
  }

  FutureOr<void> _onRepeatQuickTest(
    RepeatQuickTest event,
    Emitter<QuickTestState> emit,
  ) {
    emit(
      QuickTestState(
        status: QuickTestStatus.running,
        questions: List.from(state.questionsOrig),
      ),
    );
  }

  FutureOr<void> _onAnswerTestQuestion(
    AnswerQuickQuestion event,
    Emitter<QuickTestState> emit,
  ) {
    if (state.status == QuickTestStatus.running) {
      List<Question> questions = state.questions;
      final Question currentQuestion = state.questions.removeAt(0);
      List<Question> answers = List.from(state.answers);
      final bool isCorrect = currentQuestion.correct == event.answer;
      final bool isLastQuestion = questions.isEmpty;
      if (!isCorrect) {
        _prefs.addQuestionIdIncorrect(currentQuestion.id);
        answers.add(currentQuestion.copyWith(answer: event.answer));
      }
      emit(
        state.copyWith(
          status: isLastQuestion
              ? QuickTestStatus.finished
              : QuickTestStatus.running,
          questions: questions,
          correctCount: state.correctCount + (isCorrect ? 1 : 0),
          mistakeCount: state.mistakeCount + (isCorrect ? 0 : 1),
          answers: answers,
        ),
      );
    }
  }

  FutureOr<void> _onQuickTestReview(
    QuickTestReview event,
    Emitter<QuickTestState> emit,
  ) {
    if (state.status == QuickTestStatus.finished) {
      emit(
        state.copyWith(
          status: QuickTestStatus.reviewing,
        ),
      );
    }
  }
}
