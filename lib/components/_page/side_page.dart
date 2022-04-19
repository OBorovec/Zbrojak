import 'package:flutter/material.dart';

class SidePage extends StatelessWidget {
  final Widget body;

  const SidePage({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Positioned.fill(child: body),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
