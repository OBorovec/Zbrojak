import 'package:flutter/material.dart';

class SidePage extends StatelessWidget {
  final Widget body;
  final List<Widget> controlButtons;
  final bool forceControlSpace;

  const SidePage({
    Key? key,
    required this.body,
    this.controlButtons = const <Widget>[],
    this.forceControlSpace = false,
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
            Positioned.fill(
                child: Row(
              children: [
                Expanded(child: body),
                if (forceControlSpace)
                  const SizedBox(
                    width: 28, // 24 is the default width of  icons
                  )
              ],
            )),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                      ...controlButtons,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
