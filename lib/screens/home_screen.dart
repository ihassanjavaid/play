import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_app/components/custom_painter.dart';
import 'package:play_app/models/asset_data.dart';
import 'package:play_app/models/channel_model.dart';
import 'package:play_app/screens/likes_screen.dart';
import 'package:play_app/screens/preview_page.dart';
import 'package:play_app/screens/profile_screen.dart';
import 'package:play_app/screens/search_screen.dart';
import 'package:play_app/services/mux_client.dart';
import 'package:play_app/services/video_streaming_service.dart';
import 'package:play_app/services/youtube_api_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:play_app/widgets/alert_widget.dart';
import 'package:play_app/widgets/video_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late Widget bodyWidget;

  int numOfVideos = VideoStreamingService.getNumOfVids;
  List imagesList = VideoStreamingService.getImages();
  List videosList = VideoStreamingService.getVideos();

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }
  
  void getScreen(BuildContext context) {
    switch (currentIndex){
      case 0:
        setState(() {
          bodyWidget = buildHomeScreen(context);
        });

        break;
      case 1:
        setState(() {
          bodyWidget = BuildSearchBar(isPortrait: true);
        });

        break;
      case 2:
        setState(() {
          bodyWidget = LikedVideos();
        });

        break;
      case 3:
        setState(() {
          bodyWidget = ProfileScreen();
        });
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (currentIndex == 0) bodyWidget = buildHomeScreen(context);
    return Scaffold(
      backgroundColor: kDarkPurpleColor,
      body: bodyWidget,
      bottomNavigationBar: Container(
      height: size.height/ 9.5,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 80,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    Center(
                      heightFactor: 0.6,
                      child: FloatingActionButton(
                          backgroundColor: kPurpleColor,
                          child: Icon(Icons.video_call),
                          elevation: 0.1,
                          onPressed: () {
                            AlertWidget()
                                .generateUploadVideoDialog(
                                context: context,
                                title: "Upload Video",
                                description: "Please select the banner and the video, and then tap upload.").show();
                          }),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.home,
                              color: currentIndex == 0 ? kPurpleColor : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(0);
                              getScreen(context);
                            },
                            splashColor: Colors.white,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.search,
                                color: currentIndex == 1 ? kPurpleColor : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
                                getScreen(context);
                              }),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.bookmark,
                                color: currentIndex == 2 ? kPurpleColor : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(2);
                                getScreen(context);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: currentIndex == 3 ? kPurpleColor : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(3);
                                getScreen(context);
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHomeScreen(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 8),
              child: Container(
                height: 80,
                width: 80,
                child: Image.asset(
                    'assets/images/logo_transparent.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 31.0, left: 12),
              child: Container(
                child: Text(
                  'Play',
                  style:
                  kOnBoardingTitleStyle.copyWith(fontSize: 48, color: Colors.white),
                ),
              ),
            )
          ],
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
              /*Positioned(
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
              ),*/
              Positioned(
                bottom: 22,
                right: 12,
                child: InkWell(
                  onTap: () {
                    /*if (!video.liked!) {
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
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content:
                        Text(
                          "Video already in \'Liked Videos\'",
                          style: kOnBoardingTitleStyle.copyWith(fontSize: 18),
                        )));*/
                  },
                  child: Icon(
                    // video.liked! ? Icons.favorite : Icons.favorite_border,
                    Icons.favorite_border,
                    color: kPurpleColor,
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

  String getVideoUrl(String imageUrl) {
    return imageUrl.replaceFirst('_img', '');
  }
}



