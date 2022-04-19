import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopDialogPage extends StatefulWidget {
  final Widget body;
  final List<Widget> controlButtons;

  const PopDialogPage({
    Key? key,
    required this.body,
    this.controlButtons = const <Widget>[],
  }) : super(key: key);

  @override
  State<PopDialogPage> createState() => _PopDialogPagetate();
}

class _PopDialogPagetate extends State<PopDialogPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: widget.body),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        onWillPop().then((value) {
                          if (value) Navigator.of(context).pop();
                        });
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                    ...widget.controlButtons,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.popDialogTitle),
            content: Text(AppLocalizations.of(context)!.popDialogContent),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.popDialogNo),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.popDialogYes),
              ),
            ],
          ),
        )) ??
        false;
  }
}
