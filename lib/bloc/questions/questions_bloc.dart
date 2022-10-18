import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/prefs_repo.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final PrefsRepo _prefs;
  QuestionsBloc({
    required PrefsRepo prefs,
  })  : _prefs = prefs,
        super(const QuestionsLoading()) {
    on<LoadQuestions>(_loadQuestions);
    on<QuestionIndexChanged>(_questionIndexChanged);
    // Init
    add(const LoadQuestions());
  }

  FutureOr<void> _loadQuestions(
    LoadQuestions event,
    Emitter<QuestionsState> emit,
  ) async {
    // Load questions from assets
    final String jsonString =
        await rootBundle.loadString('assets/data/2021/questions.json');
    final List<dynamic> data = await json.decode(jsonString);
    final List<Question> questionDataSet =
        data.map<Question>((json) => Question.fromJson(json)).toList();
    // Load initIndex from Preferences
    int initIndex = _prefs.loadQuestionListingIdx() ?? 0;
    emit(
      QuestionsLoaded(
        questions: questionDataSet,
        initIndex: initIndex,
      ),
    );
  }

  FutureOr<void> _questionIndexChanged(
    QuestionIndexChanged event,
    Emitter<QuestionsState> emit,
  ) {
    _prefs.saveQuestionListingIdx(event.index);
  }
}
