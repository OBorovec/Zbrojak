import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:zbrojak/bloc/quick_test/quick_test_bloc.dart';
import 'package:zbrojak/components/pages/confirm_pop_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/services/prefs_repo.dart';

class QuickTestPage extends StatelessWidget {
  const QuickTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuickTestBloc(
        prefs: context.read<PrefsRepo>(),
      ),
      child: Builder(
        builder: (context) {
          return PopDialogPage(
            body: _buildContent(context),
            controlButtons: _addControls(context),
          );
        },
      ),
    );
  }

  List<Widget> _addControls(BuildContext context) {
    return [];
  }

  Widget _buildContent(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<QuickTestBloc, QuickTestState>(
      builder: (context, state) {
        switch (state.status) {
          case QuickTestStatus.loading:
            return _buildLoadingContent(state);
          case QuickTestStatus.running:
            return _buildTestContent(state, context);
          case QuickTestStatus.finished:
            return _buildFinishedContent(state, context);
          case QuickTestStatus.reviewing:
            return _buildReviewContent(state, height);
        }
      },
    );
  }

  Widget _buildLoadingContent(
    QuickTestState state,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (state.message != null) Text(state.message!),
        ],
      ),
    );
  }

  Widget _buildTestContent(
    QuickTestState state,
    BuildContext context,
  ) {
    return QuestionWidget(
      question: state.questions.first,
      onAnswer: (_, ans) => BlocProvider.of<QuickTestBloc>(context).add(
        AnswerQuickQuestion(answer: ans),
      ),
      highlightCorrect: false,
    );
  }

  Widget _buildFinishedContent(
    QuickTestState state,
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.quickTestResultTitle,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          '${AppLocalizations.of(context)!.quickTestResultRate} ${state.correctCount}/${state.correctCount + state.mistakeCount}',
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => BlocProvider.of<QuickTestBloc>(context)
                    .add(const QuickTestReview()),
                child: Text(
                  AppLocalizations.of(context)!.quickTestOptReview,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => BlocProvider.of<QuickTestBloc>(context)
                    .add(const RepeatQuickTest()),
                child: Text(
                  AppLocalizations.of(context)!.quickTestOptRepeat,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => BlocProvider.of<QuickTestBloc>(context)
                    .add(const NewQuickTest()),
                child: Text(
                  AppLocalizations.of(context)!.quickTestOptNew,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.of(context)!.quickTestOptLeave,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewContent(
    QuickTestState state,
    double height,
  ) {
    return CarouselSlider.builder(
      itemCount: state.answers.length,
      itemBuilder: (
        BuildContext context,
        int itemIndex,
        int pageViewIndex,
      ) {
        return QuestionWidget(
          question: state.answers[itemIndex],
          onAnswer: (_, __) {},
          highlightCorrect: true,
          highlightErrorOption: state.answers[itemIndex].answer,
        );
      },
      options: CarouselOptions(
        height: height,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
      ),
    );
  }
}
