import 'package:flutter/material.dart';
import 'package:zbrojak/model/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(int idx, String answer) onAnswer;
  final bool shuffle;
  final bool showCorrect;
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswer,
    this.shuffle = false,
    this.showCorrect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildQuestionIdx(context),
                    if (question.image != null) _buildImage(),
                    _buildQuestion(context),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildAnswers(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionIdx(BuildContext context) {
    return Text(
      question.id.toString(),
      style: Theme.of(context).textTheme.displaySmall,
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Image.asset(
        'assets/2021/images/${question.image}',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    return Text(
      question.question,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  List<Widget> _buildAnswers(BuildContext context) {
    int idx = -1;
    List<String> answers = [question.answer] + question.options;
    if (shuffle) answers.shuffle();
    int highlightIdx = answers.indexOf(question.answer);
    return answers.map(
      (ans) {
        idx++;
        return QuestionAnswer(
          text: ans,
          highlight: showCorrect && idx == highlightIdx,
          onPressed: () {
            onAnswer(idx, ans);
          },
        );
      },
    ).toList();
  }
}

class QuestionAnswer extends StatelessWidget {
  final String text;
  final bool highlight;
  final Function() onPressed;

  const QuestionAnswer({
    Key? key,
    required this.text,
    required this.highlight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        style: highlight
            ? ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              )
            : null,
      ),
    );
  }
}
