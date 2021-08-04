import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:play_app/models/user_data.dart';
import 'package:play_app/utilities/global_methods.dart';
import 'auth_service.dart';

class FirestoreUserService {
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();

  Future<void> registerUserInFirebase({required String displayName, required String email}) async {
    await checkInternetConnection();

    DocumentReference documentReference = _firestore.collection('users').doc();
    await documentReference.set({
      'displayName': displayName,
      'email': email,
    });
  }

  Future<UserData> getUserData({required String email}) async {
    UserData? userData;

    await checkInternetConnection();

    final userDocuments = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (var userDocument in userDocuments.docs) {
      userData = UserData(
        email: userDocument.data()['email'],
        displayName: userDocument.data()['displayName'],
      );
    }

    return userData!;
  }

  Future<String> getUserInitial({required String email}) async {
    String? initial;

    await checkInternetConnection();

    final userDocuments = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (var userDocument in userDocuments.docs) {
      initial =userDocument.data()['displayName'];
    }

    return initial![0];
  }

  /*Future<List<UserData>> getAllUsers() async {
    List<UserData> users = [];

    await checkInternConnection();

    // Get current user
    final currentUser = await _auth.getCurrentUser();

    // Fetch all users
    final userDocuments = await _firestore.collection('users').getDocuments();

    // Get each user
    for (var user in userDocuments.documents) {
      if (user.data()['email'] != currentUser.email) {
        UserData userData = UserData(
            displayName: user.data()['displayName'],
            email: user.data()['email']);
        users.add(userData);
      }
    }
    return users;
  }*/
}
