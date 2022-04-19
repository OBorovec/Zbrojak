import 'package:flutter/material.dart';
import 'dart:io';

import 'package:zbrojak/utils/toasting.dart';

class RootPage extends StatefulWidget {
  final Widget body;

  const RootPage({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        extendBody: true,
        body: widget.body,
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    final DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toasting.notifyToast(
        context: context,
        message: 'Double tab to exit.',
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
