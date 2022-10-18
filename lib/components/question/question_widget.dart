import 'package:flutter/material.dart';

import 'package:zbrojak/model/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(int idx, String optionKey) onAnswer;
  final bool highlightCorrect;
  final String? highlightErrorOption;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswer,
    this.highlightCorrect = false,
    this.highlightErrorOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question.id.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Center(
                child: SingleChildScrollView(
                  child: _buildQuestion(context),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: _buildAnswers(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildQuestion(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (question.image != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset(
              'assets/data/2021/images/${question.image}',
              fit: BoxFit.scaleDown,
            ),
          ),
        Text(
          question.question,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildAnswers(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: question.options.entries
          .map((e) => _QuestionAnswer(
                text: e.value,
                highlightCorrect: highlightCorrect && e.key == question.correct,
                highlightError: highlightErrorOption == e.key,
                onPressed: (() => onAnswer(question.id, e.key)),
              ))
          .toList(),
    );
  }
}

class _QuestionAnswer extends StatelessWidget {
  final String text;
  final bool highlightCorrect;
  final bool highlightError;
  final Function() onPressed;

  const _QuestionAnswer({
    Key? key,
    required this.text,
    this.highlightCorrect = false,
    this.highlightError = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(context),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: _getTextColor(context),
                ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (highlightCorrect) {
      return Theme.of(context).colorScheme.primary;
    } else if (highlightError) {
      return Theme.of(context).colorScheme.error;
    } else {
      return Theme.of(context).colorScheme.secondary;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (highlightCorrect) {
      return Theme.of(context).colorScheme.onPrimary;
    } else if (highlightError) {
      return Theme.of(context).colorScheme.onError;
    } else {
      return Theme.of(context).colorScheme.onSecondary;
    }
  }
}
