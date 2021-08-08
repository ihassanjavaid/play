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
      child: Center(
        child: Text(
          'No Liked Videos.',
          style: kOnBoardingTitleStyle,
        ),
      ),
    );
  }
}
