import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/assets_loader.dart';
import 'package:zbrojak/services/prefs_repo.dart';

part 'incorrect_questions_event.dart';
part 'incorrect_questions_state.dart';

class IncQuestionsBloc extends Bloc<IncQuestionsEvent, IncQuestionsState> {
  final PrefsRepo _prefs;
  late List<Question> questions;
  IncQuestionsBloc({
    required PrefsRepo prefs,
  })  : _prefs = prefs,
        super(const IncQuestionsLoading()) {
    on<LoadIncQuestions>(_loadIncorrectQuestions);
    on<RemoveCurrentIncQuestion>(_removeIncorrectQuestion);
    on<IncQuestionIndexChanged>(_incQuestionIndexChanged);
  }

  FutureOr<void> _loadIncorrectQuestions(
    LoadIncQuestions event,
    Emitter<IncQuestionsState> emit,
  ) async {
    final List<Question> questionDataSet =
        (await parseJsonFromAssets('assets/2021/questions.json')
                as List<dynamic>)
            .map((e) => Question.fromMap(e))
            .toList();
    final List<int> incorrectQuestionIds = _prefs.loadQuestionIdsIncorrect();
    emit(
      IncQuestionsLoaded(
        questions: questionDataSet
            .where((Question q) => incorrectQuestionIds.contains(q.id))
            .toList(),
        idx: 0,
      ),
    );
  }

  FutureOr<void> _removeIncorrectQuestion(
    RemoveCurrentIncQuestion event,
    Emitter<IncQuestionsState> emit,
  ) {
    if (state is IncQuestionsLoaded) {
      IncQuestionsLoaded loadedState = state as IncQuestionsLoaded;
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

  FutureOr<void> _incQuestionIndexChanged(
    IncQuestionIndexChanged event,
    Emitter<IncQuestionsState> emit,
  ) {
    if (state is IncQuestionsLoaded) {
      emit(
        (state as IncQuestionsLoaded).copyWith(
          idx: event.index,
        ),
      );
    }
  }
}
