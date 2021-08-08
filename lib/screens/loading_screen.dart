import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:play_app/models/user_data.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/services/auth_service.dart';
import 'package:play_app/services/firestore_user_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:play_app/widgets/alert_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  final String name;
  final String email;
  final String password;
  final Auth auth;
  final bool rememberMe;
  UserData userData;
  final FirestoreUserService firestoreUserService;
  User? fbUser;
  final LoadingType loadingType;

  LoadingScreen({required this.name, required this.email, required this.password, required this.auth,
  required this.rememberMe, required this.userData, required this.firestoreUserService, this.fbUser,
  required this.loadingType});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    if (widget.loadingType == LoadingType.SIGNIN) {
      waitForLogIn();
    }
    else if (widget.loadingType == LoadingType.SIGNUP){
      //waitForRegistration();
    }
  }


  Future<void> waitForLogIn() async {

  }

  Future<void> waitForRegistration() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Center(
        child: SpinKitChasingDots(
          color: kTealColor,
          size: 80.0,
        ),
      ),
    );
  }
}
