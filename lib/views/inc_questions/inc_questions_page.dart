import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zbrojak/bloc/incorrect_questions/incorrect_questions_bloc.dart';
import 'package:zbrojak/components/_page/side_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/services/prefs_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zbrojak/utils/toasting.dart';

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
                Toasting.notifyToast(
                    context: context,
                    message: AppLocalizations.of(context)!
                        .incorrectQuestionsPageToastWillBeRemoved,
                    gravity: ToastGravity.CENTER);
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
            print('rebuilding');
            return CarouselSlider(
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
              items: state.questions.map((question) {
                return QuestionWidget(
                  question: question,
                  onAnswer: (_, __) {},
                  shuffle: false,
                  showCorrect: true,
                );
              }).toList(),
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
