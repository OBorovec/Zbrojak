import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zbrojak/model/question.dart';
import 'package:zbrojak/services/assets_loader.dart';

part 'all_questions_event.dart';
part 'all_questions_state.dart';

class AllQuestionsBloc extends Bloc<AllQuestionsEvent, AllQuestionsState> {
  late List<Question> questions;
  AllQuestionsBloc() : super(const AllQuestionsLoading()) {
    on<LoadQuestions>(_loadQuestions);
    on<QuestionIndexChanged>(_questionIndexChanged);
  }

  FutureOr<void> _loadQuestions(
    LoadQuestions event,
    Emitter<AllQuestionsState> emit,
  ) async {
    // Load questions from assets
    final List<dynamic> questionDataSet =
        await parseJsonFromAssets('assets/2021/questions.json')
            as List<dynamic>;
    questions = questionDataSet.map((e) => Question.fromMap(e)).toList();
    // Load initIndex from Preferences
    //  TODO: ^^
    emit(
      AllQuestionsLoaded(
        questions: questions,
        initIndex: 0,
      ),
    );
  }

  FutureOr<void> _questionIndexChanged(
    QuestionIndexChanged event,
    Emitter<AllQuestionsState> emit,
  ) {
    // TODO: Store index in Preferences
  }
}
