import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbrojak/bloc/simple_test/simple_test_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> showResultDialog(
  BuildContext rootContext,
  int correntCount,
  int mistakeCount,
) {
  return showDialog(
    context: rootContext,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.simpleTestDiagResultTitle,
      ),
      content: Text(
        AppLocalizations.of(context)!
            .simpleTestDiagResultContent(correntCount, mistakeCount),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            BlocProvider.of<SimpleTestBloc>(rootContext).add(ResetSimpleTest());
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.simpleTestDiagResultRepeat,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(rootContext).pop();
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.simpleTestDiagResultLeave,
          ),
        ),
      ],
    ),
  );
}
