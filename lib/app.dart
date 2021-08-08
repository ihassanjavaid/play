import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:play_app/routes.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:play_app/utilities/constants.dart';

class Play extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kPlayThemeData,
      title: 'Play',
      home: AnimatedSplashScreen(
        splashIconSize: 200,
        duration: 2600,
        nextScreen: LoginScreen(),
        // nextScreen: HomeScreen(),
        splash: Image.asset(
          'assets/images/logo_transparent.png',
        ),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: kDarkPurpleColor,
      ),
      routes: DefaultPlayRoute.DEFAULT_ROUTE,
    );
  }
}