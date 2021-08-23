import 'package:flutter/material.dart';
import 'package:play_app/screens/preview_page.dart';
import 'package:play_app/services/firestore_video_service.dart';
import 'package:play_app/services/video_streaming_service.dart';
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

class LikedVideos extends StatefulWidget {
  const LikedVideos({
    Key? key,
  }) : super(key: key);

  @override
  _LikedVideosState createState() => _LikedVideosState();
}

class _LikedVideosState extends State<LikedVideos> {
  FirestoreVideoService _firestoreVideoService = FirestoreVideoService();
  List imagesList = VideoStreamingService.getImages();
  List videosList = VideoStreamingService.getVideos();
  List<String> finalList = [];

  Future<List<dynamic>>? getLikedVids() async {
    return await _firestoreVideoService.getLikedVideos()!;
  }

  Future<List> getLikedList() async {
    List<int>? likedVideosId = [];
    List docs = [];
    docs = await _firestoreVideoService.getLikedVideos()!;
    for (var i in docs){
      likedVideosId.add(int.parse(i.id));
    }
    finalList = [];
    for (var i in likedVideosId){
      finalList.add(VideoStreamingService.getSingleVideo(i));
    }
    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kScaffoldBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36.0, left: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Watch Later',
                style: kOnBoardingTitleStyle.copyWith(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          FutureBuilder<List>(
              future: getLikedList(),
              builder: (context, snapshot) {
                if (finalList.isNotEmpty){
                  return Container(
                      height: size.height * 0.72,
                      width: size.width,
                      child: Container(
                        child: ListView.builder(
                          itemCount: finalList.length,
                          itemBuilder: (BuildContext context, int index) {
                            bool liked = false;
                            // if (likedVideosId.contains(index.toString())){
                            //   liked = true;
                            // }
                            return _buildVideo(finalList[index], liked);
                          },
                        ),
                      ));
                } else {
                  return Container(
                    height: size.height * 0.72,
                    width: size.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPurpleColor,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              }
          ),
        ],
      ),
    );
  }

  Widget _buildVideo(String image, bool isLiked) {
    /*if (video != null) {
      if (likedVidsIds.contains(video.id)){
        video.liked = true;
      }
    }*/
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: GestureDetector(
        onTap: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(video: video!),
            ),
          );*/
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PreviewPage(videoUrl: getVideoUrl(image))));
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
              /*Positioned(
                bottom: 22,
                right: 12,
                child: InkWell(
                  onTap: () {

                  },
                  child: GestureDetector(
                    onTap: () async {
                      if (isLiked){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                              'Video already liked.',
                              style: kOnBoardingTitleStyle.copyWith(fontSize: 20, color: Colors.white),
                            ),
                            ));
                      } else {
                        String? id = image.split('/').last.split('_').first;
                        print("Video to be liked ID: $id");
                        try{
                          await _firestoreVideoService.likeVideo(id);
                        } catch (e) {
                          print("Can\'t like: ${e.toString()}");
                        }
                      }
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      //Icons.favorite_border,
                      color: kPurpleColor,
                      size: 30,
                    ),
                  ),
                ),
              )*/
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

  String getVideoUrl(String imageUrl) {
    return VideoStreamingService.getVideoUrl(imageUrl);
  }
}
