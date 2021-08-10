import 'package:flutter/material.dart';
import 'package:play_app/services/auth_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'on_boarding_screen.dart';

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
      color: kScaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 48),
            child: Text(
                "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
                style: kOnBoardingTitleStyle.copyWith(fontSize: 30.0)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 30),
            child: CircleAvatar(
              backgroundColor: kTealColor.withOpacity(0.75),
              radius: 80,
              child: Icon(
                Icons.person,
                color: kTealColor.withOpacity(0.55),
                size: 80,
              ),
            ),
          ),
          FutureBuilder(
            future: _getUserName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Hi, ${snapshot.data.toString()}.",
                      style: kOnBoardingTitleStyle.copyWith(color: kAmberColor),
                    ),
                  ),
                );
              }
            },
          ),
          FutureBuilder(
            future: _getUseremail(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "${snapshot.data.toString()}.",
                      style: kOnBoardingTitleStyle.copyWith(color: kAmberColor.withOpacity(0.75), fontSize: 20),
                    ),
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Text(
                "This app streams videos\ndirectly from YouTube\nin high quality",
                style: kOnBoardingTitleStyle.copyWith(color: kTealColor.withOpacity(0.7)),
              ),
            ),
          ),
          buildAmberDivider(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: GestureDetector(
                onTap: () async {
                  Auth _auth = Auth();
                  final SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.setString('email', '');
                  await pref.setString('displayName', "User");
                  await pref.setString('uid', "");
                  try{
                    _auth.signOut();
                    Navigator.pushNamed(context, OnBoardingScreen.id);
                  }
                  catch (e) {}
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Sign Out",
                      style: kOnBoardingTitleStyle.copyWith(color: kTealColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 2.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: kTealColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
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

  Future<String> _getUseremail() async {
    String? _email;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _email = pref.getString('email');
    // to display only first name
    if (_email != null)
      return _email;
    return '';
  }
}
