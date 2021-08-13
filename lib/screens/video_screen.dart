import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_app/models/channel_model.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/services/firestore_video_service.dart';
import 'package:play_app/services/youtube_api_service.dart';
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
  FirestoreVideoService _firestoreVideoService = FirestoreVideoService();
  Channel? _channel;
  bool _showFloatingButton = false;

  List<String?> likedVidsIds = [];

  final ScrollController _scrollController = ScrollController();

  String channelID = 'UCVD09YmuX1QwX4XSyI84q5g';

  @override
  void initState() {
    super.initState();
    _initChannel();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video!.id!,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        controlsVisibleAtStart: true,
      ),
    );
  }

  _initChannel() async {
    Channel channel =
        await YoutubeAPIService.instance.fetchChannel(channelId: channelID);
    List? likedVds = await _firestoreVideoService.getLikedVideos();
    likedVds?.forEach((element) {
      likedVidsIds.add(element['id']);
    });

    setState(() {
      this._channel = channel;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.video != null) {
      await _firestoreVideoService.addLastWatchedVideo(widget.video!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            mini: true,
            onPressed: () {
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            backgroundColor: kAmberColor,
            child: Icon(Icons.arrow_upward),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: kTealColor,
            child: Icon(Icons.home),
          ),
        ],
      ),
      body: FutureBuilder(builder: (context, snapshot) {
        if (_channel != null) {
          return Column(
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
                padding:
                    const EdgeInsets.only(top: 12.0, right: 12.0, left: 12),
                child: Text(
                  widget.video!.title!,
                  style: kOnBoardingTitleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      minRadius: 22,
                      maxRadius: 22,
                      backgroundColor: kTealColor,
                      backgroundImage:
                          NetworkImage(_channel!.profilePictureUrl!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.video!.channelTitle!,
                            style: kOnBoardingTitleStyle.copyWith(
                                color: kTealColor.withOpacity(0.4),
                                fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${formatSubCount(_channel!.subscriberCount!)} Subscribers",
                            style: kOnBoardingTitleStyle.copyWith(
                                color: kTealColor.withOpacity(0.4),
                                fontSize: 14,
                                fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildAmberDivider(),
              /*Expanded(
                child: Center(
                  child: Text(
                    'No Related Videos',
                    style: kOnBoardingTitleStyle.copyWith(color: kTealColor.withOpacity(0.5)),
                  ),
                ),
              )*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Related Videos',
                  style: kOnBoardingTitleStyle,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.2,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    List<Widget> videos = [];
                    _channel?.videos?.forEach((video) {
                      videos.add(_buildVideo(video));
                    });
                    return Column(
                      children: videos,
                    );
                  },
                ),
              ),
            ],
          );
        } else
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: kTealColor,
            color: kAmberColor,
          ));
      }),
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

  Widget _buildVideo(Video? video) {
    if (video != null) {
      if (likedVidsIds.contains(video.id)) {
        video.liked = true;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(video: video!),
            ),
          );
        },
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            children: [
              Container(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FractionallySizedBox(
                    widthFactor: 1.2,
                    child: Image.network(
                      video!.thumbnailUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: kAmberColor,
                  ),
                  height: 42,
                  width: MediaQuery.of(context).size.width - 200,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                    child: Text("${video.title!.substring(0, 12)}...",
                        //overflow: ,
                        style: kOnBoardingTitleStyle.copyWith(
                            color: kScaffoldBackgroundColor, fontSize: 22)),
                  ),
                ),
              ),
              Positioned(
                bottom: 22,
                right: 12,
                child: InkWell(
                  onTap: () {
                    if (!video.liked!) {
                      print("${video.title} liked");
                      try {
                        _firestoreVideoService.likeVideo(video);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Liked: ${video.title}",
                          style: kOnBoardingTitleStyle.copyWith(fontSize: 18),
                        )));
                        setState(() {
                          video.liked = true;
                        });
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Video already in \'Liked Videos\'",
                      style: kOnBoardingTitleStyle.copyWith(fontSize: 18),
                    )));
                  },
                  child: Icon(
                    video.liked! ? Icons.favorite : Icons.favorite_border,
                    color: kAmberColor,
                    size: 30,
                  ),
                ),
              )
              /*Positioned(
                bottom: 16,
                left: 146,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: kAmberColor,
                  ),
                  height: 42,
                  width: 42,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.8, left: 9.8),
                    child: Text('E1',
                        style: kOnBoardingTitleStyle.copyWith(
                            color: kScaffoldBackgroundColor, fontSize: 22)),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  String formatSubCount(String? subs) {
    if (subs!.contains('000')) return subs.replaceAll('000', 'K');
    return subs;
  }
}
