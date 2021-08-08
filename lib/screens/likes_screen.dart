import 'package:flutter/material.dart';
import 'package:play_app/utilities/constants.dart';

class LikesScreen extends StatefulWidget {
  static const String id = "likes_screen";
  const LikesScreen({Key? key}) : super(key: key);

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) {
    return LikedVideos();
  }
}

class LikedVideos extends StatelessWidget {
  const LikedVideos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kScaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 24,
            child: Text(
              'Watch Later',
              style: kOnBoardingTitleStyle.copyWith(color: Colors.white, fontSize: 40),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text(
                'No Saved Videos.',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: kLightPurpleColor,
                  fontSize: 22
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
