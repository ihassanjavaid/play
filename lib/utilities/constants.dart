import 'package:flutter/material.dart';
// import 'package:flutter_stream/secrets.dart';
import 'package:play_app/utilities/keys.dart';

const accessTokenMUX = MUX_TOKEN_ID;
const secretTokenMUX = MUX_TOKEN_SECRET;

// API for sending videos
const muxBaseUrl = 'https://api.mux.com';

// API server running on localhost
const muxServerUrl = 'http://10.0.2.2:3000';

// API for generating thumbnails of a video
const muxImageBaseUrl = 'https://image.mux.com';

// API for streaming a video
const muxStreamBaseUrl = 'https://stream.mux.com';

// Received video file format
const videoExtension = 'm3u8';

// Thumbnail file type and size
const imageTypeSize = 'thumbnail.jpg?time=5&width=200';

// Content Type used in API calls
const contentType = 'application/json';

// Access token in corrent format
const authToken = '$accessTokenMUX:$secretTokenMUX';

// Test video url provided by MUX
const demoVideoUrl = 'https://storage.googleapis.com/muxdemofiles/mux-video-intro.mp4';

// Specifying playback policy to public
const playbackPolicy = 'public';

// Colors

// final kScaffoldBackgroundColor = Color(0xFFedf5f4);
final kScaffoldBackgroundColor = kDarkPurpleColor;
final kMedTealColor = Color(0xff599186);
final kTealColor = Color(0xff45736A);
final kDarkTealColor = Color(0xff26403b);
final kAmberColor = Color(0xffF2B035);
final kLightAmberColor = Color(0xffF2CA7E);
final kPeachColor = Color(0xffF2AA80);

final kDarkPurpleColor = Color(0xff241c3c);
final kLightPurpleColor = Color(0xffa6bcee);
final kPurpleColor = Color(0xff8267f7);

// Theme data
final kPlayThemeData = ThemeData(
  backgroundColor: kScaffoldBackgroundColor,
  dialogBackgroundColor: Colors.white,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
);

// Enumerations
enum LoadingType { SIGNIN, SIGNUP }

//
final kLoginBoxDecorationStyle = BoxDecoration(
  color: kTealColor.withOpacity(0.8),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: kScaffoldBackgroundColor,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

// Text Style

final kLoginHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Nunito',
);

final kLoginLabelStyle = TextStyle(
  color: kTealColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);

final kBottomNavBarTextStyle = TextStyle(
  fontSize: 22.0,
  color: kTealColor,
  fontFamily: 'Nunito',
);

final kOnBoardingTitleStyle = TextStyle(
  color: kTealColor,
  fontFamily: 'Nunito',
  fontSize: 26.0,
  height: 1.5,
);

final kOnBoardingSubtitleStyle = TextStyle(
  color: kTealColor,
  fontSize: 18.0,
  height: 1.2,
);

final kNavyBarTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 18.0,
  height: 1.2,
);

class CustomColors {
  static const Color muxPink = Color(0xFFff1f78);
  static const Color muxPinkLight = Color(0xFFff709a);
  static const Color muxPinkVeryLight = Color(0xFFfef6f7);
  static const Color muxOrange = Color(0xFFff4b03);
  static const Color muxOrangeLight = Color(0xFFff7d6e);
  static const Color muxGray = Color(0xFF383838);
  static const Color muxGrayLight = Color(0xFFf9f9f9);
}