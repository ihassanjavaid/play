import 'package:flutter/material.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/screens/loading_screen.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:play_app/screens/on_boarding_screen.dart';
import 'package:play_app/screens/registration_screen.dart';

class DefaultPlayRoute{

  static Map<String, WidgetBuilder> _defaultRoute = {
    //AutoLoginService.id:(context) => AutoLoginService(),
    HomeScreen.id: (context) => HomeScreen(),
    LoginScreen.id: (context) => LoginScreen(),
    RegistrationScreen.id: (context) => RegistrationScreen(),
    //LoadingScreen.id: (context) => LoadingScreen()
    OnBoardingScreen.id: (context) => OnBoardingScreen()
  };

  static Map<String, WidgetBuilder> get DEFAULT_ROUTE => _defaultRoute;
}