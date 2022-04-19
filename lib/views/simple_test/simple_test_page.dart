import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbrojak/bloc/simple_test/simple_test_bloc.dart';
import 'package:zbrojak/components/_page/confirm_pop_page.dart';
import 'package:zbrojak/components/question/question_widget.dart';
import 'package:zbrojak/views/simple_test/simple_test_dialogs.dart';

class SimpleTestPage extends StatelessWidget {
  const SimpleTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SimpleTestBloc()..add(LoadSimpleTest()),
      child: Builder(builder: (context) {
        return PopDialogPage(
          body: _buildBlocLogic(context),
          controlButtons: _gameControlIcons(context),
        );
      }),
    );
  }

  List<Widget> _gameControlIcons(BuildContext context) {
    return [];
  }

  Widget _buildBlocLogic(BuildContext context) {
    return BlocConsumer<SimpleTestBloc, SimpleTestState>(
      listenWhen: (previous, current) {
        if (previous is SimpleTestRunning && current is SimpleTestRunning) {
          return previous.status != current.status;
        }
        return false;
      },
      listener: (context, state) {
        if (state is SimpleTestRunning) {
          switch (state.status) {
            case TetsStatus.finished:
              showResultDialog(
                context,
                state.correctCount,
                state.mistakeCount,
              );
              break;
            case TetsStatus.running:
              break;
          }
        }
      },
      builder: (context, state) {
        if (state is SimpleTestRunning) {
          return QuestionWidget(
            question: state.getQuestion(),
            onAnswer: (_, ans) => BlocProvider.of<SimpleTestBloc>(context).add(
              AnswerQuestion(answer: ans),
            ),
            shuffle: true,
            showCorrect: false,
          );
        } else if (state is SimpleTestLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                if (state.message != null) Text(state.message!),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
