import 'package:flutter/material.dart';
import 'package:zbrojak/bloc/simple_test/simple_test_bloc.dart';

class SimpleTestLoadingWidget extends StatelessWidget {
  final SimpleTestLoading state;
  const SimpleTestLoadingWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
