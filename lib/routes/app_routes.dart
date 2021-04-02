import 'package:flutter/material.dart';

import 'package:flutter_bloc_practice_2/views/first_screen.dart';
import 'package:flutter_bloc_practice_2/views/second_screen.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: "First Screen",
                ));
        break;

      case "/second":
        return MaterialPageRoute(
            builder: (_) => SecondScreen(
                  title: "Second Screen",
                ));
        break;
      default:
        return null;
    }
  }
}
