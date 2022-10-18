import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/prefs_repo.dart';

part 'questions_review_event.dart';
part 'questions_review_state.dart';

class QuestionsReviewBloc
    extends Bloc<IncQuestionsEvent, QuestionsReviewState> {
  final PrefsRepo _prefs;
  late List<Question> questions;
  QuestionsReviewBloc({
    required PrefsRepo prefs,
  })  : _prefs = prefs,
        super(const QuestionsReviewLoading()) {
    on<LoadQuestionsReview>(_onLoadQuestionsReview);
    on<RemoveQuestionFromReview>(_onRemoveQuestionFromReview);
    on<QuestionsReviewIndexChanged>(_onQuestionsReviewIndexChanged);
    // Init
    add(const LoadQuestionsReview());
  }

  FutureOr<void> _onLoadQuestionsReview(
    LoadQuestionsReview event,
    Emitter<QuestionsReviewState> emit,
  ) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/2021/questions.json');
    final List<dynamic> data = await json.decode(jsonString);
    final List<Question> questionDataSet =
        data.map<Question>((json) => Question.fromJson(json)).toList();
    final List<int> incorrectQuestionIds = _prefs.loadQuestionIdsIncorrect();
    emit(
      QuestionsReviewLoaded(
        questions: questionDataSet
            .where((Question q) => incorrectQuestionIds.contains(q.id))
            .toList(),
        idx: 0,
      ),
    );
  }

  FutureOr<void> _onRemoveQuestionFromReview(
    RemoveQuestionFromReview event,
    Emitter<QuestionsReviewState> emit,
  ) {
    if (state is QuestionsReviewLoaded) {
      QuestionsReviewLoaded loadedState = state as QuestionsReviewLoaded;
      _prefs.removeQuestionIdIncorrect(
        loadedState.questions[loadedState.idx].id,
      );
      // Create new list without current question
      List<Question> newQuestions = loadedState.questions.toList();
      newQuestions.removeAt(loadedState.idx);
      emit(loadedState.copyWith(
          questions: newQuestions,
          idx: min(loadedState.idx, newQuestions.length - 1)));
    }
  }

  FutureOr<void> _onQuestionsReviewIndexChanged(
    QuestionsReviewIndexChanged event,
    Emitter<QuestionsReviewState> emit,
  ) {
    if (state is QuestionsReviewLoaded) {
      emit(
        (state as QuestionsReviewLoaded).copyWith(
          idx: event.index,
        ),
      );
    }
  }
}
