import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/utilities/global_methods.dart';

import 'auth_service.dart';

class FirestoreVideoService{
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();
  User? _user;

  Future<String?> getCurrentUserEmail() async {
    _user = await _auth.getCurrentUser();
    return _user?.email;
  }


  Future<void> likeVideo(Video? video) async {
    await checkInternetConnection();
    String? _email = await getCurrentUserEmail();

    DocumentReference documentReference =
    _firestore.collection('videos').doc();

    try{
      if (video != null){
        await documentReference.set({
          'email': _email,
          'id': video.id,
          'title': video.title,
          'channelTitle': video.channelTitle,
          'thumbnailUrl': video.thumbnailUrl,
          // for showing the reminders in app in order 'last posted first'
          'timestamp': DateTime.now().millisecondsSinceEpoch
        });
      }
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future getLikedVideos() async {
    checkInternetConnection();
    String? _email = await getCurrentUserEmail();

    QuerySnapshot querySnapshot = await _firestore
        .collection('videos')
        .where('email', isEqualTo: _email)
        .get();

    return querySnapshot.docs;
  }

}