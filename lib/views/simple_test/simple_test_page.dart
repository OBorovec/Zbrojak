import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbrojak/bloc/simple_test/simple_test_bloc.dart';
import 'package:zbrojak/components/_page/confirm_pop_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zbrojak/views/simple_test/simple_test_dialogs.dart';
import 'package:zbrojak/views/simple_test/simple_test_loading.dart';
import 'package:zbrojak/views/simple_test/simple_test_running.dart';

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
          return SimpleTestRunningWidget(state: state);
        } else if (state is SimpleTestLoading) {
          return SimpleTestLoadingWidget(state: state);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
