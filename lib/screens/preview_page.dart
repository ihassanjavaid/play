import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:play_app/services/video_streaming_service.dart';
import 'package:play_app/utilities/constants.dart';

class PreviewPage extends StatefulWidget {
  final String videoUrl;

  const PreviewPage({required this.videoUrl});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {

  int numOfVideos = VideoStreamingService.getNumOfVids;
  List imagesList = VideoStreamingService.getImages();
  List videosList = VideoStreamingService.getVideos();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint('Replaced URL: ${widget.videoUrl}');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: kPurpleColor,
        child: Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                width: double.maxFinite,
                /*child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.muxPink,
                    ),
                    strokeWidth: 2,
                  ),
                ),*/
                child: BetterPlayer.network(
                    widget.videoUrl,
                  betterPlayerConfiguration: BetterPlayerConfiguration(
                    // fullScreenByDefault: true,
                    autoPlay: true,
                    aspectRatio: 16/9,
                    autoDispose: true
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width - 20,
                color: kPurpleColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Text(
                'Related Videos',
                style: kOnBoardingTitleStyle.copyWith(color: kPurpleColor),
              )
            ),
            Container(
                height: size.height * 0.72,
                width: size.width,
                child: Container(
                  child: ListView.builder(
                    itemCount: videosList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildVideo(imagesList[index]);
                    },

                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideo(String image) {
    /*if (video != null) {
      if (likedVidsIds.contains(video.id)){
        video.liked = true;
      }
    }*/
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: GestureDetector(
        onTap: (){
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(video: video!),
            ),
          );*/
          Navigator.push(context, MaterialPageRoute(builder:
              (context) => PreviewPage(videoUrl: getVideoUrl(image))
          ));
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
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getVideoUrl(String imageUrl) {
    return VideoStreamingService.getVideoUrl(imageUrl);
  }
}
