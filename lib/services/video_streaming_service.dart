import 'package:flutter/foundation.dart';
import 'package:play_app/utilities/address.dart';

class VideoStreamingService{
  static int _numOfVids = 4;

  static int get getNumOfVids => _numOfVids;

  static List getVideos() {
    List<String> videosList = [];

    for ( var i = 1 ; i <= _numOfVids ; i++){
      videosList.add('$IP_ADDRESS:$PORT/$i');
    }

    debugPrint('Videos:\n');
    for ( var j in videosList){
      debugPrint(j);
    }

    return videosList;
  }

  static List getImages() {
    List<String> imagesList = [];

    for ( var i = 1 ; i <= _numOfVids ; i++){
      imagesList.add('$IP_ADDRESS:$PORT/${i}_img');
    }

    debugPrint('Images:\n');
    for ( var j in imagesList){
      debugPrint(j);
    }

    return imagesList;
  }
}