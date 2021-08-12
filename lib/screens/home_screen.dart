import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:play_app/models/channel_model.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/screens/likes_screen.dart';
import 'package:play_app/screens/profile_screen.dart';
import 'package:play_app/screens/search_screen.dart';
import 'package:play_app/screens/video_screen.dart';
import 'package:play_app/services/firestore_video_service.dart';
import 'package:play_app/services/youtube_api_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:play_app/widgets/alert_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:shimmer/shimmer.dart';

class OverLay extends StatelessWidget {
  OverLay({Key? key}) : super(key: key);

  final List<FocusNode> overlayKeys = <FocusNode>[
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  Widget build(BuildContext context) {

    final List<OnboardingStep> steps = [OnboardingStep(
      focusNode: overlayKeys[0],
      title: "Hi",
      titleTextStyle: Theme.of(context).textTheme.headline5!.copyWith(
        color: Theme.of(context).canvasColor,
      ),
      bodyText:
      '''Check this out''',
      bodyTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
        color: Theme.of(context).canvasColor,
      ),
      hasLabelBox: false,
      fullscreen: true,
      overlayColor: Theme.of(context).primaryColorDark.withOpacity(0.8),
      hasArrow: false,
    ),];

    return Onboarding(
      steps: steps,
      child: HomeScreen(nodes: overlayKeys,),
    );
  }
}


class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key, required this.nodes,}) : super(key: key);

  final List<FocusNode> nodes;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Widget bodyWidget;
  bool showContinueWatching = false;

  Channel? _channel;
  bool _showFloatingButton = false;
  FirestoreVideoService _firestoreVideoService = FirestoreVideoService();

  List<String?> likedVidsIds = [];

  final ScrollController _scrollController = ScrollController();

  String channelID = 'UCVD09YmuX1QwX4XSyI84q5g';



  @override
  void initState() {
    _initChannel();
    super.initState();

  }


  void getScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //bodyWidget = buildHomeScreen(size);
    switch (_currentIndex){
      case 0:
        setState(() {
          bodyWidget = buildHomeScreen(size);
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
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;
    if (_currentIndex == 0) bodyWidget = buildHomeScreen(size);


    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      backgroundColor: kScaffoldBackgroundColor,
      body: bodyWidget,
      bottomNavigationBar: BottomNavyBar(
        iconSize: 28,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 22,
        curve: Curves.easeIn,
        backgroundColor: kScaffoldBackgroundColor,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //onItemSelected: (index) => setState(() => _currentIndex = index),
        onItemSelected: (index) {
          _currentIndex = index;
          getScreen(context);

        },
        containerHeight: 62,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home', style: kNavyBarTextStyle),
            activeColor: kAmberColor,
            inactiveColor: kTealColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search', style: kNavyBarTextStyle),
            activeColor: kAmberColor,
            inactiveColor: kTealColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Likes', style: kNavyBarTextStyle),
            activeColor: kAmberColor,
            inactiveColor: kTealColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile', style: kNavyBarTextStyle),
            activeColor: kAmberColor,
            inactiveColor: kTealColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildFloatingActionButton() {
    _showFloatingButton = _currentIndex == 0;
    return Visibility(
      visible: _showFloatingButton,
      child: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(0,
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn);
        },
        mini: true,
        backgroundColor: kTealColor,
        foregroundColor: kAmberColor,
        child: Icon(
          Icons.keyboard_arrow_up_outlined,
        ),
      ),
    );
  }

  Widget buildHomeScreen(Size size) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (_channel == null){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kTealColor,
              color: kAmberColor,
            ),
          );
        }
        else {

          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              List<Widget> videos = [];
              _channel?.videos?.forEach((video) {
                videos.add(_buildVideo(video));
              });
              return Container(
                //height: size.height,
                //color: kScaffoldBackgroundColor,
                decoration: BoxDecoration(
                    /*gradient: LinearGradient(
                        colors: [Color(0xffe8e0d1), kScaffoldBackgroundColor, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.01, 0.05, 0.1])*/
                  color: kScaffoldBackgroundColor
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                      'assets/images/logo_transparent.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0, left: 12),
                                child: Container(
                                  child: Shimmer.fromColors(
                                    baseColor: kTealColor, 
                                    highlightColor: kTealColor.withOpacity(0.5),
                                    direction: ShimmerDirection.ltr,
                                    period: Duration(seconds: 3),
                                    child: Text(
                                      'Play',
                                      style:
                                      kOnBoardingTitleStyle.copyWith(fontSize: 38),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0, top: 8),
                            child: Container(
                              child: Focus(
                                focusNode: widget.nodes.first,
                                child: InkWell(
                                  onTap: () async {
                                    if (showContinueWatching == false) {
                                      setState(() {
                                        showContinueWatching = true;

                                      });

                                      return;
                                    }
                                    Video? lastWatched = await _firestoreVideoService.getLastWatchedVideo();
                                    if (lastWatched == null) {
                                      AlertWidget()
                                          .generateContiueWatchingAlert(
                                          context: context,
                                          title: "Nothing to Show!",
                                          description: 'No videos found in history to show. Please continue to Homepage.')
                                          .show();
                                      setState(() {
                                        showContinueWatching = false;

                                      });
                                    } else {

                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => VideoScreen(video: lastWatched),
                                        ),
                                      );
                                      setState(() {
                                        showContinueWatching = false;
                                      });
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.history,
                                        size: 36,
                                        color: kAmberColor,
                                        semanticLabel: 'Continue Watching',
                                      ),
                                      if (showContinueWatching) AnimatedSwitcher(
                                        duration: Duration(seconds: 1,),
                                        child: Text(
                                          'Continue\nWatching',
                                          style: kOnBoardingTitleStyle.copyWith(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      buildAmberDivider(),
                      /*FutureBuilder(
                        future: _getUserName(),
                        builder:
                            (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (!snapshot.hasData) {
                            return Text('');
                          } else {
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 0.0),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Hi, ${snapshot.data.toString()}!\n',
                                          style: kOnBoardingTitleStyle
                                        ),
                                        TextSpan(
                                            text: 'Continue Watching >',
                                            style: kOnBoardingTitleStyle
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      buildAmberDivider(),*/
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 0.0),
                        child: Container(
                          child: Text(
                            'Featured',
                            style: kOnBoardingTitleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12.0),
                        child: Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.circular(12.0),
                          child: Stack(
                            children: [
                              Container(
                                height: size.height / 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: FractionallySizedBox(
                                    widthFactor: 1.2,
                                    child: Image.network(
                                      _channel!.videos![4].thumbnailUrl!,
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
                                  width: 120,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(top: 2.0, left: 8.0),
                                    child: Text('Thoughts...',
                                        style: kOnBoardingTitleStyle.copyWith(
                                            color: kScaffoldBackgroundColor,
                                            fontSize: 22)),
                                  ),
                                ),
                              ),
                              Positioned(
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
                                    padding:
                                    const EdgeInsets.only(top: 2.8, left: 9.8),
                                    child: Text('E1',
                                        style: kOnBoardingTitleStyle.copyWith(
                                            color: kScaffoldBackgroundColor,
                                            fontSize: 22)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      buildAmberDivider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 0.0),
                        child: Container(
                          child: Text(
                            'New Arrivals',
                            style: kOnBoardingTitleStyle,
                          ),
                        ),
                      ),
                      Column(
                        children: videos,
                      ),
                      /*Container(
                        height: 1000,
                        child: ListView.builder(
                          //controller: _scrollController,
                          itemCount: _channel!.videos!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Video video = _channel!.videos![index];
                            return _buildVideo(video);
                          },
                        ),
                      ),*/
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
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

  Future<String> _getUserName() async {
    String? _name;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _name = pref.getString('displayName');
    // to display only first name
    if (_name!.contains(' ')) {
      _name = _name.substring(0, _name.indexOf(' '));
    }
    return _name;
  }

  Widget _buildVideo(Video? video) {
    if (video != null) {
      if (likedVidsIds.contains(video.id)){
        video.liked = true;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
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
}
