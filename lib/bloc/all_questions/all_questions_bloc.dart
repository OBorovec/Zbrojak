import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/assets_loader.dart';
import 'package:zbrojak/services/prefs_repo.dart';

part 'all_questions_event.dart';
part 'all_questions_state.dart';

class AllQuestionsBloc extends Bloc<AllQuestionsEvent, AllQuestionsState> {
  final PrefsRepo _prefs;
  AllQuestionsBloc({
    required PrefsRepo prefs,
  })  : _prefs = prefs,
        super(const AllQuestionsLoading()) {
    on<LoadQuestions>(_loadQuestions);
    on<QuestionIndexChanged>(_questionIndexChanged);
  }

  FutureOr<void> _loadQuestions(
    LoadQuestions event,
    Emitter<AllQuestionsState> emit,
  ) async {
    // Load questions from assets
    final List<Question> questionDataSet =
        (await parseJsonFromAssets('assets/2021/questions.json')
                as List<dynamic>)
            .map((e) => Question.fromMap(e))
            .toList();
    // Load initIndex from Preferences
    int initIndex = _prefs.loadQuestionListingIdx() ?? 0;
    emit(
      AllQuestionsLoaded(
        questions: questionDataSet,
        initIndex: initIndex,
      ),
    );
  }

  FutureOr<void> _questionIndexChanged(
    QuestionIndexChanged event,
    Emitter<AllQuestionsState> emit,
  ) {
    _prefs.saveQuestionListingIdx(event.index);
  }
}
