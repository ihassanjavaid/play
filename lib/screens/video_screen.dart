import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final Video? video;

  VideoScreen({this.video});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video!.id!,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: kTealColor,
        child: Icon(
          Icons.home
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            progressIndicatorColor: kTealColor,
            controller: _controller!,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 12.0, left: 12),
            child: Text(
              widget.video!.title!,
              style: kOnBoardingTitleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              widget.video!.channelTitle!,
              style: kOnBoardingTitleStyle.copyWith(color: kTealColor.withOpacity(0.4), fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          buildAmberDivider(),
          Expanded(
            child: Center(
              child: Text(
                'No Related Videos',
                style: kOnBoardingTitleStyle.copyWith(color: kTealColor.withOpacity(0.5)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding buildAmberDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
        color: kAmberColor,
        height: 2,
      ),
    );
  }
}
