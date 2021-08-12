import 'package:flutter/material.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/screens/likes_screen.dart';
import 'package:play_app/screens/loading_screen.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:play_app/screens/on_boarding_screen.dart';
import 'package:play_app/screens/profile_screen.dart';
import 'package:play_app/screens/registration_screen.dart';
import 'package:play_app/screens/search_screen.dart';
import 'package:play_app/services/auto_login_service.dart';

class DefaultPlayRoute{

  static Map<String, WidgetBuilder> _defaultRoute = {
    AutoLoginService.id:(context) => AutoLoginService(),
    HomeScreen.id: (context) => OverLay(),
    LoginScreen.id: (context) => LoginScreen(),
    RegistrationScreen.id: (context) => RegistrationScreen(),
    //LoadingScreen.id: (context) => LoadingScreen()
    OnBoardingScreen.id: (context) => OnBoardingScreen(),
    SearchScreen.id: (context) => SearchScreen(),
    LikesScreen.id: (context) => LikesScreen(),
    ProfileScreen.id: (context) => ProfileScreen()
  };

  static Map<String, WidgetBuilder> get DEFAULT_ROUTE => _defaultRoute;
}