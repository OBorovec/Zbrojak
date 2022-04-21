import 'package:flutter/material.dart';
import 'package:zbrojak/views/all_questions/all_questions_page.dart';
import 'package:zbrojak/views/home/home_page.dart';
import 'package:zbrojak/views/inc_questions/inc_questions_page.dart';
import 'package:zbrojak/views/setting/settings_page.dart';
import 'package:zbrojak/views/simple_test/simple_test_page.dart';

class RoutePaths {
  static const String home = '/';
  static const String test = '/test';
  static const String questions = '/otazky';
  static const String mistakes = '/mojechyby';
  static const String tricks = '/triky';
  static const String stats = '/statistika';
  static const String settings = '/nastaveni';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutePaths.test:
        return MaterialPageRoute(builder: (_) => const SimpleTestPage());
      case RoutePaths.questions:
        return MaterialPageRoute(builder: (_) => AllQuestionsPage());
      case RoutePaths.mistakes:
        return MaterialPageRoute(builder: (_) => IncQuestionsPage());
      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      // Default
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('404'),
        ),
      );
    });
  }
}
