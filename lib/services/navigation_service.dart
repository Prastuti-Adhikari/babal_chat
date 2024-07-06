import 'package:babal_chat/pages/home_page.dart';
import 'package:babal_chat/pages/login_page.dart';
import 'package:babal_chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, WidgetBuilder> _routes = {
    "/login": (context) => const LoginPage(),
    "/register": (context) => const RegisterPage(),
    "/home": (context) => const Homepage(),
  };

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  Map<String, WidgetBuilder> get routes => _routes;

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route){
    _navigatorKey.currentState?.push(route);
  }
  
  void pushNamed(String routeName, {Object? arguments}) {
    _navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void pushReplacementName(String routeName, {Object? arguments}) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
