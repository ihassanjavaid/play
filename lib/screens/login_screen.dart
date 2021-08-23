import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:play_app/models/user_data.dart';
import 'package:play_app/screens/home_screen.dart';
import 'package:play_app/services/auth_service.dart';
import 'package:play_app/services/firestore_user_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:play_app/widgets/alert_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);
  Auth _auth = Auth();
  FirestoreUserService firestoreUserService = FirestoreUserService();
  User? fbUser;

  String removeSpaces(String email) {
    if (email == null) return 'null';
    return email.replaceAll(' ', '');
  }

  Future<String?> _authUser(LoginData data) async {
    try {
      final SharedPreferences pref =
          await SharedPreferences.getInstance();
      await _auth.loginUserWithEmailAndPassword(
          email: removeSpaces(data.name), password: data.password);
        await pref.setString('email', removeSpaces(data.name));

      UserData userData = await firestoreUserService.getUserData(email: data.name);
      await pref.setString('displayName', userData.displayName);
      /* Set UID in shared prefs so that it can be accessed in community forums*/

      fbUser = (await _auth.getCurrentUser())!;
    await pref.setString('uid', fbUser!.uid);
    // Pop all the previous screens
    //Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
    // Navigate to the main screen
    return null;
    } catch (e) {
    /*AlertWidget()
        .generateAlert(
    context: context,
    title: 'Invalid Credentials!',
    description: e.toString())
        .show();
    print(e);*/
      return "Invalid Credentials!";
    }
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
        return '';
    });
  }

  Future<String?> _RegUser(LoginData data) async {
    try {
      // register user in Firebase Auth
      await _auth.registerUser(
          email: removeSpaces(data.name), password: data.password);
      // register user in Firebase Firestore
      await firestoreUserService.registerUserInFirebase(
          displayName: data.name, email: data.name);
      // register user in device locally - shared prefs
      final SharedPreferences pref =
      await SharedPreferences.getInstance();
      await pref.setString('email', removeSpaces(data.name));
      await pref.setString('displayName', data.name);
      // Pop all the previous screens
      //Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      // Navigate to the main screen
      //Navigator.pushNamed(context, HomeScreen.id);
      return null;
    } catch (e) {
      /*AlertWidget()
          .generateAlert(
          context: context, title: "Error", description: e.toString())
          .show();
      print(e);*/
      return "Unable to Register. Please try again!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: FlutterLogin(
          theme: LoginTheme(
            // cardTheme: CardTheme(
            //   //color: Colors.yellow.shade100,
            //   elevation: 5,
            //   margin: EdgeInsets.only(top: 15),
            //   shape: ContinuousRectangleBorder(
            //       borderRadius: BorderRadius.circular(100.0)),
            // ),
            primaryColor: kDarkPurpleColor,
            accentColor: kLightPurpleColor,
            errorColor: Colors.red,
            switchAuthTextColor: kDarkPurpleColor,
            titleStyle: TextStyle(
              color: kLightPurpleColor,
              fontFamily: 'Nunito',
              letterSpacing: 0,
            ),
          ),
          hideForgotPasswordButton: true,
          title: 'Watchtime',
          logo: 'assets/images/logo_transparent.png',
          onLogin: _authUser,
          onSignup: _RegUser,
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
          },
          onRecoverPassword: _recoverPassword,
        ),
      ),
    );
  }
}

