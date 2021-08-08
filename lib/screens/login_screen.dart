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

/*class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  String? _password;
  UserData? _userData;
  bool _rememberMe = false;
  Auth _auth = Auth();
  FirestoreUserService _firestore = FirestoreUserService();
  //User _fbuser;
  //String _uid;

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kLoginBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              this._email = value;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kLoginHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kLoginBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            onChanged: (value) {
              this._password = value;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kLoginHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 22.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: kTealColor),
            child: Checkbox(
              value: _rememberMe,
              checkColor: kTealColor,
              activeColor: kScaffoldBackgroundColor,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.5),
            child: Text(
              'Keep me signed in',
              style: kLoginLabelStyle.copyWith(color: kTealColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: GestureDetector(
        onTap: () {
          _userData = UserData(email: this._email!, displayName: "");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoadingScreen(
                        email: this._email!,
                        password: this._password!,
                        rememberMe: _rememberMe,
                        //fbUser: this._fbuser!,
                        firestoreUserService: this._firestore,
                        auth: this._auth,
                        userData: this._userData!,
                        loadingType: LoadingType.SIGNIN,
                        name: this._userData!.displayName,
                      )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Log In',
                  style: kBottomNavBarTextStyle.copyWith(fontSize: 22.0)),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kTealColor,
              size: 30.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildORText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: kTealColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 2.0),
      ],
    );
  }

  Widget _buildGSignIn() {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign in with',
            style: kLoginLabelStyle.copyWith(fontSize: 20),
          ),
          SizedBox(
            width: 25.0,
          ),
          GestureDetector(
            onTap: () async {
              // try {
              //   await _auth.signInWithG();
              //   _fbuser = await _auth.getCurrentUser();
              //   _uid = _fbuser.uid;
              //   final SharedPreferences pref =
              //       await SharedPreferences.getInstance();
              //
              //   await pref.setString('uid', _uid);
              //   await pref.setString('email', _fbuser.email);
              //   await pref.setString('displayName', _fbuser.displayName);
              //   UserData userforcheck = await _firestore.getUserData(email:_fbuser.email);
              //   if (userforcheck == null) {
              //     await _firestore.registerUserInFirebase(displayName: _fbuser.displayName, email: _fbuser.email);
              //   }
              //   Navigator.pushReplacementNamed(context, Dashboard.id);
              // } catch (e) {
              //   AlertWidget()
              //       .generateAlert(
              //           context: context,
              //           title: 'Sign In Error!',
              //           description: 'Google Sign in Failed. Please Try Again.')
              //       .show();
              //   print(e);
              // }
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
                *//* image: DecorationImage(
                  image: AssetImage (
                    'assets/logos/google_icon.jpg',
                  ),
                ),*//*
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset('assets/logos/google_icon.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RegistrationScreen.id);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: kTealColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: kAmberColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: kScaffoldBackgroundColor,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          child: Image(
                            image: AssetImage(
                                'assets/images/logo_transparent.png'),
                            height: 120.0,
                            width: 120.0,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 2.0,
                          width: 300.0,
                          color: kAmberColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0, bottom: 10.0),
                        child: Text('Sign In',
                            style: kBottomNavBarTextStyle.copyWith(
                                fontSize: 30.0)),
                      ),
                      SizedBox(height: 18.0),
                      _buildEmailTextField(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTextField(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildRememberMeCheckbox(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildLoginBtn(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildORText(),
                      _buildGSignIn(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/

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
    return FlutterLogin(
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
      title: 'Play',
      logo: 'assets/images/logo_transparent.png',
      onLogin: _authUser,
      onSignup: _RegUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}

