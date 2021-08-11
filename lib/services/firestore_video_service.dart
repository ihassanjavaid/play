import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:play_app/models/video_model.dart';
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

  Future<void> likeVideo(Video? video) async {
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
            .collection('likedVideos')
            .doc(video?.id)
            .update(video!.toMap());
      } catch (e) {
        print('in update catch: ${e.toString()}');
        try {
          DocumentReference documentReference = await _firestore
              .collection('users')
              .doc(userDoc)
              .collection('likedVideos')
              .doc(video?.id);
          documentReference.set(video!.toMap());
        } catch (e) {
          print('can\'t update: ${e.toString()}');
        }
      }
    }

    // DocumentReference documentReference =
    // _firestore.collection('videos').doc();

    /*var querySnapshot = await
    _firestore.collection('videos').where('email', isEqualTo: _email).get();

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
    }*/
  }

  Future<List<QueryDocumentSnapshot<Object?>>?> getLikedVideos() async {
    checkInternetConnection();
    String? _email = await getCurrentUserEmail();

    /*QuerySnapshot querySnapshot = await _firestore
        .collection('videos')
        .where('email', isEqualTo: _email)
        .get();*/

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
          .collection('likedVideos')
          .get();

      return querySnapshot.docs;
    }
  }

  Future<void> addLastWatchedVideo(Video video) async {
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
            .collection('lastWatched')
            .get()
            .then((value) {
          for (DocumentSnapshot ds in value.docs) {
            ds.reference.delete();
          }
        });
      } catch (e) {}

      try {
        await _firestore
            .collection('users')
            .doc(userDoc)
            .collection('lastWatched')
            .doc(video.id)
            .update(video.toMap());
      } catch (e) {
        print('in update catch: ${e.toString()}');
        try {
          DocumentReference documentReference = await _firestore
              .collection('users')
              .doc(userDoc)
              .collection('lastWatched')
              .doc(video.id);
          documentReference.set(video.toMap());
        } catch (e) {
          print('can\'t update: ${e.toString()}');
        }
      }
    }
  }

  Future<Video?> getLastWatchedVideo() async {
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

      try {
        querySnapshot = await _firestore
            .collection('users')
            .doc(userDoc)
            .collection('lastWatched')
            .get();
      }
      catch (e) {
        return null;
      }

      if (querySnapshot.docs.isNotEmpty) {
        return Video(
            id: querySnapshot.docs[0]['id'],
            channelTitle: querySnapshot.docs[0]['channelTitle'],
            thumbnailUrl: querySnapshot.docs[0]['thumbnailUrl'],
            title: querySnapshot.docs[0]['title'],
            liked: true);
      }

      return null;
    }
  }
}
