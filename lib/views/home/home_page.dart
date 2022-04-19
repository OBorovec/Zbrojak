import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zbrojak/components/_page/root_page.dart';
import 'package:zbrojak/route_generator.dart';
import 'package:zbrojak/utils/toasting.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.test,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionQuickTest,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Toasting.notifyToast(
                  context: context,
                  message: 'Not implemented yet...',
                );
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionAllQuestions,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Toasting.notifyToast(
                  context: context,
                  message: 'Not implemented yet...',
                );
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionTips,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Toasting.notifyToast(
                  context: context,
                  message: 'Not implemented yet...',
                );
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionFailedQuestions,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Toasting.notifyToast(
                  context: context,
                  message: 'Not implemented yet...',
                );
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionStats,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Toasting.notifyToast(
                  context: context,
                  message: 'Not implemented yet...',
                );
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionSettings,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                AppLocalizations.of(context)!.mainOptionLeave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
