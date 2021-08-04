import 'package:flutter/material.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/screens/login_screen.dart';

class DefaultPlayRoute{

  static Map<String, WidgetBuilder> _defaultRoute = {
    //AutoLoginService.id:(context) => AutoLoginService(),
    HomeScreen.id: (context) => HomeScreen(),
    LoginScreen.id: (context) => LoginScreen()
  };

  static Map<String, WidgetBuilder> get DEFAULT_ROUTE => _defaultRoute;
}