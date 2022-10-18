import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zbrojak/bloc/questions/questions_bloc.dart';
import 'package:zbrojak/components/pages/side_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/services/prefs_repo.dart';

class AllQuestionsPage extends StatelessWidget {
  AllQuestionsPage({Key? key}) : super(key: key);

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsBloc(
        prefs: context.read<PrefsRepo>(),
      ),
      child: Builder(builder: (context) {
        return SidePage(
          body: _buildBody(context),
          controlButtons: [
            ...List<int>.generate(10, (i) => i * 50)
                .map(
                  (e) => IconButton(
                    onPressed: () => _carouselController.animateToPage(e),
                    icon: Text(e.toString()),
                  ),
                )
                .toList(),
            IconButton(
              onPressed: () => _carouselController.animateToPage(0),
              icon: const Icon(Icons.menu_book),
            ),
            IconButton(
              onPressed: () => _carouselController.animateToPage(358),
              icon: Image.asset(
                'assets/icons/gun.png',
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            IconButton(
              onPressed: () => _carouselController.animateToPage(463),
              icon: const Icon(Icons.local_hospital),
            )
          ],
          forceControlSpace: true,
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoaded) {
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: state.initIndex,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                BlocProvider.of<QuestionsBloc>(context).add(
                  QuestionIndexChanged(index: index),
                );
              },
            ),
            carouselController: _carouselController,
            items: state.questions.map((question) {
              return QuestionWidget(
                question: question,
                onAnswer: (_, __) => null,
                highlightCorrect: true,
              );
            }).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
