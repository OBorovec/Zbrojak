import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbrojak/bloc/incorrect_questions/incorrect_questions_bloc.dart';
import 'package:zbrojak/components/_page/side_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/services/prefs_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncQuestionsPage extends StatelessWidget {
  IncQuestionsPage({Key? key}) : super(key: key);

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncQuestionsBloc(
        prefs: context.read<PrefsRepo>(),
      )..add(LoadIncQuestions()),
      child: Builder(builder: (context) {
        return SidePage(
          body: _buildBody(context),
          controlButtons: [
            IconButton(
              onPressed: () {
                BlocProvider.of<IncQuestionsBloc>(context).add(
                  RemoveCurrentIncQuestion(),
                );
              },
              icon: const Icon(Icons.check),
            )
          ],
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<IncQuestionsBloc, IncQuestionsState>(
      builder: (context, state) {
        if (state is IncQuestionsLoaded) {
          if (state.questions.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: state.questions.length,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) {
                return Hero(
                  tag:
                      'incQuestion_' + state.questions[itemIndex].id.toString(),
                  child: QuestionWidget(
                    question: state.questions[itemIndex],
                    onAnswer: (_, __) {},
                    shuffle: false,
                    showCorrect: true,
                  ),
                );
              },
              options: CarouselOptions(
                height: height,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 0,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  BlocProvider.of<IncQuestionsBloc>(context).add(
                    IncQuestionIndexChanged(index: index),
                  );
                },
              ),
              carouselController: carouselController,
            );
          } else {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.incorrectQuestionsPageNoMistakes,
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
