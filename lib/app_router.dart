import 'package:flutter/material.dart';
import 'package:test_test/presentation/screens/dashboard_screen.dart';
import 'package:test_test/presentation/screens/unknown_page.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings setting){
    switch(setting.name){
      case "/" :
        return MaterialPageRoute(builder: (context) => DashboardScreen());
      case "/mainScreen":
        return MaterialPageRoute(builder: (context) => DashboardScreen());
      default:
        return MaterialPageRoute(builder: (context) => UnknownScreen());
    }
  }
}