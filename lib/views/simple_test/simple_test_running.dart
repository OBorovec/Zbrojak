import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbrojak/bloc/simple_test/simple_test_bloc.dart';

class SimpleTestRunningWidget extends StatelessWidget {
  final SimpleTestRunning state;
  const SimpleTestRunningWidget({
    Key? key,
    required this.state,
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
                    if (state.currentImage != null) _buildImage(),
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

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Image.asset(
        'assets/2021/images/${state.currentImage}',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    return Center(
      child: Text(
        state.currentQuestion,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  List<Widget> _buildAnswers(BuildContext context) {
    return state.currentAnswers
        .map(
          (ans) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => BlocProvider.of<SimpleTestBloc>(context).add(
                AnswerQuestion(answer: ans),
              ),
              child: Text(
                ans,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        )
        .toList();
  }
}
