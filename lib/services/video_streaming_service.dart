import 'package:flutter/foundation.dart';
import 'package:play_app/utilities/address.dart';

class VideoStreamingService{
  static int _numOfVids = 4;

  static int get getNumOfVids => _numOfVids;

  static List getVideos() {
    List<String> videosList =
    [
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fvideos%2F1.mp4?alt=media&token=3c0049a8-f4e8-4c3e-b65d-8a020029a7bd',
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fvideos%2F2.mp4?alt=media&token=6183d328-56ed-4cb8-b92e-0d0f3c92c55e',
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fvideos%2F3.mp4?alt=media&token=80de8dbb-95c3-4247-90f9-91a4d31fc8ae',
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fvideos%2F4.mp4?alt=media&token=208f22c7-2a78-432b-8760-12c3e5fb85fb'
    ];

    // for ( var i = 1 ; i <= _numOfVids ; i++){
    //   videosList.add('$IP_ADDRESS:$PORT/$i');
    // }

    debugPrint('Videos:\n');
    for ( var j in videosList){
      debugPrint(j);
    }

    return videosList;
  }

  static List getImages() {
    List<String> imagesList =
    [
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fimages%2F1.jpg?alt=media&token=f7b99a17-5a19-4073-ba1a-f80da9e302c1',
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fimages%2F2.jpg?alt=media&token=b15cc682-8eb6-405f-9795-8df9588d9544',
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fimages%2F3.jpg?alt=media&token=ee3318bd-f036-4f28-afa3-1333ec39b188',
      'https://firebasestorage.googleapis.com/v0/b/the-play-app.appspot.com/o/res%2Fimages%2F4.jpg?alt=media&token=d0fb2183-1721-4e41-bd75-8c92ef777a44'
    ];

    // for ( var i = 1 ; i <= _numOfVids ; i++){
    //   imagesList.add('$IP_ADDRESS:$PORT/${i}_img');
    // }

    debugPrint('Images:\n');
    for ( var j in imagesList){
      debugPrint(j);
    }

    return imagesList;
  }

  static String getVideoUrl(String imageUrl) {
    List imagesList = VideoStreamingService.getImages();
    List videoList = VideoStreamingService.getVideos();
    int index = imagesList.indexOf(imageUrl);
    return videoList[index];
  }

  static String getSingleVideo(int videoNum) {
    List imagesList = VideoStreamingService.getImages();
    return imagesList[videoNum-1];
  }

  static String? search(String query) {
    List imagesList = VideoStreamingService.getImages();
    List<String> titles = [
      'The School System - Sued - Einstein',
      'No Excuses - Motivation',
      'Inside the mind of a master procastinator - The Panic Monster - TED',
      'No Excuses, No Worries, No Regrets, No Fear, Go All In'
    ];

    for (var i in titles){
      if (i.contains(query)){
        print('search found!');
        return imagesList[titles.indexOf(i)];
      }
    }
  }
}