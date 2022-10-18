import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zbrojak/components/pages/root_page.dart';
import 'package:zbrojak/route_generator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HomeOption(
                text: AppLocalizations.of(context)!.mainOptionQuickTest,
                action: () => Navigator.pushNamed(
                  context,
                  RoutePaths.test,
                ),
              ),
              _HomeOption(
                text: AppLocalizations.of(context)!.mainOptionAllQuestions,
                action: () => Navigator.pushNamed(
                  context,
                  RoutePaths.questions,
                ),
              ),
              _HomeOption(
                text: AppLocalizations.of(context)!.mainOptionFailedQuestions,
                action: () => Navigator.pushNamed(
                  context,
                  RoutePaths.mistakes,
                ),
              ),
              // _HomeOption(
              //   text: AppLocalizations.of(context)!.mainOptionTips,
              //   action: () => Toasting.notifyToast(
              //     context: context,
              //     message: 'Not implemented yet...',
              //   ),
              // ),
              // _HomeOption(
              //   text: AppLocalizations.of(context)!.mainOptionStats,
              //   action: () => Toasting.notifyToast(
              //     context: context,
              //     message: 'Not implemented yet...',
              //   ),
              // ),
              // _HomeOption(
              //   text: AppLocalizations.of(context)!.mainOptionSettings,
              //   action: () => Toasting.notifyToast(
              //     context: context,
              //     message: 'Not implemented yet...',
              //   ),
              // ),
              _HomeOption(
                text: AppLocalizations.of(context)!.mainOptionLeave,
                action: () => exit(0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeOption extends StatelessWidget {
  final String text;
  final Function() action;
  const _HomeOption({
    Key? key,
    required this.text,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: action,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
