import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zbrojak/bloc/questions_review/questions_review_bloc.dart';
import 'package:zbrojak/components/pages/side_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/services/prefs_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionsReviewPage extends StatelessWidget {
  QuestionsReviewPage({Key? key}) : super(key: key);

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsReviewBloc(
        prefs: context.read<PrefsRepo>(),
      ),
      child: Builder(builder: (context) {
        return SidePage(
          body: _buildBody(context),
          controlButtons: [
            IconButton(
              onPressed: () {
                BlocProvider.of<QuestionsReviewBloc>(context).add(
                  const RemoveQuestionFromReview(),
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
    return BlocBuilder<QuestionsReviewBloc, QuestionsReviewState>(
      builder: (context, state) {
        if (state is QuestionsReviewLoaded) {
          if (state.questions.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: state.questions.length,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) {
                return QuestionWidget(
                  question: state.questions[itemIndex],
                  onAnswer: (_, __) {},
                  highlightCorrect: true,
                );
              },
              options: CarouselOptions(
                height: height,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 0,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  BlocProvider.of<QuestionsReviewBloc>(context).add(
                    QuestionsReviewIndexChanged(index: index),
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
