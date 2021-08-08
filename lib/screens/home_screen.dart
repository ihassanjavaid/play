import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_app/components/custom_painter.dart';
import 'package:play_app/models/asset_data.dart';
import 'package:play_app/models/channel_model.dart';
import 'package:play_app/screens/likes_screen.dart';
import 'package:play_app/screens/profile_screen.dart';
import 'package:play_app/screens/search_screen.dart';
import 'package:play_app/services/mux_client.dart';
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

  final ScrollController _scrollController = ScrollController();

  String channelID = 'UCVD09YmuX1QwX4XSyI84q5g';

  MUXClient _muxClient = MUXClient();

  TextEditingController? _textControllerVideoURL;
  FocusNode? _textFocusNodeVideoURL;

  @override
  void initState() {
    super.initState();
    _muxClient.initializeDio();
    _textControllerVideoURL = TextEditingController(text:demoVideoUrl);
    _textFocusNodeVideoURL = FocusNode();
  }

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
      height: size.height/6,
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
                                description: "Please paste the URL of the video to upload:").show();
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
            height: size.height /2,
            width: size.width,
            child: Container(
              child: FutureBuilder<AssetData>(
                future: _muxClient.getAssetList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AssetData? assetData = snapshot.data;
                    int length = assetData!.data!.length;

                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: length,
                      itemBuilder: (context, index) {
                        String? dateTimeToParse = assetData.data![index]!.createdAt;
                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(dateTimeToParse!) * 1000);
                        DateFormat formatter = DateFormat.yMd().add_jm();
                        String dateTimeString = formatter.format(dateTime);

                        String? currentStatus = assetData.data![index]!.status;
                        bool isReady = currentStatus == 'ready';

                        String? playbackId = isReady
                            ? assetData.data![index]!.playbackIds![0]!.id
                            : null;

                        String? thumbnailURL = isReady
                            ? '$muxImageBaseUrl/$playbackId/$imageTypeSize'
                            : null;

                        return VideoTile(
                          assetData: assetData.data![index]!,
                          thumbnailUrl: thumbnailURL!,
                          isReady: isReady,
                          dateTimeString: dateTimeString,
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(
                        height: 16.0,
                      ),
                    );
                  }
                  else {
                    return Container(
                      child: Center(
                        child: Text(
                          'Sorry,\nNo videos present',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nunito',
                              fontSize: 28
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
        ),
      ],
    );
  }
}



