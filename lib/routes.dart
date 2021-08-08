import 'package:flutter/material.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/screens/likes_screen.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:play_app/screens/profile_screen.dart';
import 'package:play_app/screens/search_screen.dart';

class DefaultPlayRoute{

  static Map<String, WidgetBuilder> _defaultRoute = {
    HomeScreen.id: (context) => HomeScreen(),
    LoginScreen.id: (context) => LoginScreen(),
    SearchScreen.id: (context) => SearchScreen(),
    LikesScreen.id: (context) => LikesScreen(),
    ProfileScreen.id: (context) => ProfileScreen()
  };

  static Map<String, WidgetBuilder> get DEFAULT_ROUTE => _defaultRoute;
}