import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zbrojak/constants/theme.dart';
import 'package:zbrojak/route_generator.dart';
import 'package:zbrojak/services/prefs_repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

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
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildMaterialApp(
    BuildContext context,
    String initRoute,
  ) {
    return MaterialApp(
      title: 'BlavApp',
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
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
