import 'package:flutter/material.dart';

// Colors

final kScaffoldBackgroundColor = Color(0xFFedf5f4);
final kMedTealColor = Color(0xff599186);
final kTealColor = Color(0xff45736A);
final kDarkTealColor = Color(0xff26403b);
final kAmberColor = Color(0xffF2B035);
final kLightAmberColor = Color(0xffF2CA7E);
final kPeachColor = Color(0xffF2AA80);


// Theme data
final kPlayThemeData = ThemeData(
  backgroundColor: kScaffoldBackgroundColor,
  dialogBackgroundColor: kScaffoldBackgroundColor,
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
  fontFamily: 'CM Sans Serif',
);

final kLoginLabelStyle = TextStyle(
  color: kTealColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'CM Sans Serif',
);

final kBottomNavBarTextStyle = TextStyle(
  fontSize: 22.0,
  color: kTealColor,
  fontFamily: 'CM Sans Serif',
);

final kOnBoardingTitleStyle = TextStyle(
  color: kTealColor,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kOnBoardingSubtitleStyle = TextStyle(
  color: kTealColor,
  fontSize: 18.0,
  height: 1.2,
);

final kNavyBarTextStyle = TextStyle(
  fontFamily: 'CM Sans Serif',
  fontSize: 18.0,
  height: 1.2,
);