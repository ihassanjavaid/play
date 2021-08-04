import 'package:firebase_auth/firebase_auth.dart';
import 'package:play_app/utilities/global_methods.dart';

class Auth {
  final _auth = FirebaseAuth.instance;


  /*Future<void> signInWithG() async {
    await checkInternetConnection();
    try {
      GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // changed from AuthResult
        UserCredential authResult =
        await _auth.signInWithCredential(credential);
        // changes from FirebaseUser
        User user = await _auth.currentUser;
      }
    } catch (e) {
      print(e.toString());
      throw(e);
    }

  }*/

  Future<User?> getCurrentUser() async => await _auth.currentUser;

  Future<void> signOut() async {
    //User? user = _auth.currentUser;
    /*if (user.providerData[0].providerId == 'google.com') {
      await _gSignIn.disconnect();
    }*/
    await _auth.signOut();
  }

  Future<void> loginUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await checkInternetConnection();

    // Use the email and password to sign-in the user
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      throw 'Invalid username or password';
    }
  }

  Future<void> registerUser({required String email, required String password}) async {
    await checkInternetConnection();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
      throw e.toString().split(']').last;
    }
  }

}
