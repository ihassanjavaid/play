import 'package:flutter/material.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoLoginService extends StatelessWidget {
  static const String id = 'auto_login_service';

  void routeDecider(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? user_email = pref.getString('email');

    print("User Email: $user_email");

    if (user_email != null) {
      if (user_email == ''){
        print('New User - First time sign in');
        Navigator.pushReplacementNamed(context, LoginScreen.id);
        return;
      }
      else {
        print('Returning User - Logged in automatically');
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        return;
      }
    } else {
      print('New User - First time sign in');
      Navigator.pushReplacementNamed(context, LoginScreen.id);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    routeDecider(context);
    return Container();
  }
}