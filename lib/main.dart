import 'package:flutter/material.dart';
import 'package:play_app/app.dart';
import 'package:play_app/init.dart';
import 'package:play_app/screens/home_screen.dart';

void main() async {
  // perform the necessary initializations
  await init();
  // launch app
  runApp(Play());
}
