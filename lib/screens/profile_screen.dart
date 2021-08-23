import 'package:flutter/material.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:play_app/services/auth_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "profile_screen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kPurpleColor, Colors.white70])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      CircleAvatar(
                        backgroundColor: kDarkPurpleColor,
                        foregroundColor: kDarkPurpleColor,
                        backgroundImage: AssetImage('assets/images/logo_transparent.png'),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Watchtime",
                        style: kOnBoardingTitleStyle.copyWith(color: kDarkPurpleColor, fontSize: 40),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   "Bio:",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontStyle: FontStyle.normal,
                  //       fontSize: 28.0
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Text(
                    'This app streams\npremium content in high definition and live content with ultra low latency.',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontFamily: 'Nunito'),
                  )
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () async {
                  Auth _auth = Auth();
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.setString('email', "");
                  await pref.setString('displayName', "User");
                  await pref.setString('uid', "");
                  try {
                    _auth.signOut();
                  } catch (e) {}
                  _auth.signOut();
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.white, Colors.white70]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: kDarkPurpleColor,
                          fontSize: 26.0,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Padding buildAmberDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
      child: Container(
        color: kAmberColor,
        height: 2,
      ),
    );
  }

  Future<String> _getUserName() async {
    String? _name;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _name = pref.getString('displayName');
    // to display only first name
    if (_name!.contains(' ')) {
      _name = _name.substring(0, _name.indexOf(' '));
    }
    return _name;
  }
}
