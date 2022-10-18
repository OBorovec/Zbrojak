import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:zbrojak/constants/theme.dart';
import 'package:zbrojak/route_generator.dart';
import 'package:zbrojak/services/prefs_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const ZbrojakApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }
}

class ZbrojakApp extends StatefulWidget {
  const ZbrojakApp({
    Key? key,
  }) : super(key: key);

  @override
  State<ZbrojakApp> createState() => _ZbrojakAppState();
}

class _ZbrojakAppState extends State<ZbrojakApp> {
  late final Future<List> _future = Future.wait(
    [
      SharedPreferences.getInstance(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildMaterialError(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.done) {
          final SharedPreferences sharedPreferences =
              snapshot.requireData[0] as SharedPreferences;
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => PrefsRepo(sharedPreferences),
              ),
            ],
            child: _buildMaterialApp(
              context,
              RoutePaths.home,
            ),
          );
        } else {
          return _buildMaterialLoading();
        }
      },
    );
  }

  Widget _buildMaterialApp(
    BuildContext context,
    String initRoute,
  ) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: initRoute,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(
        settings,
      ),
    );
  }

  Widget _buildMaterialError(
    String message,
  ) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialLoading() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
