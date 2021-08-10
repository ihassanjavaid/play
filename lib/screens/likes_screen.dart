import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/screens/video_screen.dart';
import 'package:play_app/services/firestore_video_service.dart';
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
  final ScrollController _scrollController = ScrollController();
  FirestoreVideoService _firestoreVideoService = FirestoreVideoService();

  Padding buildAmberDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
        color: kAmberColor,
        height: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 18, right: 18),
      child: Container(
        color: kScaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Liked Videos',
                style: kOnBoardingTitleStyle.copyWith(fontSize: 38),
              ),
            ),
            buildAmberDivider(),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: FutureBuilder(
                future: _getLikedVideos(),
                builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                  if (!snapshot.hasData){
                    return Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: kTealColor,
                          color: kAmberColor,
                        ),
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Video video = Video(
                            id: snapshot.data![index]['id'],
                            channelTitle: snapshot.data![index]['channelTitle'],
                            thumbnailUrl: snapshot.data![index]['thumbnailUrl'],
                            title: snapshot.data![index]['title'],
                          liked: true
                        );
                        return _buildVideo(video);
                      },
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<QueryDocumentSnapshot<Object?>>> _getLikedVideos() async {
    return await _firestoreVideoService.getLikedVideos();
  }

  _buildVideo(Video? video) {
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
                    print("${video.title} liked");
                    try{
                      _firestoreVideoService.likeVideo(video);

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:
                          Text(
                            "Liked: ${video.title}",
                            style: kOnBoardingTitleStyle.copyWith(fontSize: 18),
                          )));
                      setState(() {
                        video.liked = true;
                      });
                    } catch (e) {
                      debugPrint(e.toString());
                    }
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
}
