import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:play_app/utilities/global_methods.dart';

import 'auth_service.dart';

class FirestoreVideoService {
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();
  User? _user;

  Future<String?> getCurrentUserEmail() async {
    _user = await _auth.getCurrentUser();
    return _user?.email;
  }

  Future<void> likeVideo(String? videoID) async {
    await checkInternetConnection();
    String? _email = await getCurrentUserEmail();

    if (_email != null) {
      print('inside if');
      final userDocs = await _firestore
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();

      var userDoc;

      userDocs.docs.forEach((doc) {
        userDoc = doc.id;
      });

      print(userDoc);

      try {
        await _firestore
            .collection('users')
            .doc(userDoc)
            .collection('likedServerVideos')
            .doc(videoID)
            .update({"videoID": videoID});
      } catch (e) {
        print('in update catch: ${e.toString()}');
        try {
          DocumentReference documentReference = await _firestore
              .collection('users')
              .doc(userDoc)
              .collection('likedServerVideos')
              .doc(videoID);
          documentReference.set({"videoID": videoID});
        } catch (e) {
          print('can\'t update: ${e.toString()}');
        }
      }
    }
  }

  Future<List<dynamic>>? getLikedVideos() async {
    checkInternetConnection();
    String? _email = await getCurrentUserEmail();

    QuerySnapshot? querySnapshot;

    if (_email != null) {
      final userDocs = await _firestore
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();

      var userDoc;

      userDocs.docs.forEach((doc) {
        userDoc = doc.id;
      });
      querySnapshot = await _firestore
          .collection('users')
          .doc(userDoc)
          .collection('likedServerVideos')
          .get();

      return querySnapshot.docs;
    }
    List list = [];
    return list;
  }
}
