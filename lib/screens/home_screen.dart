import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:play_app/models/channel_model.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/services/youtube_api_service.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Channel? _channel;
  bool _isLoading = false;

  String channelID = 'UCVD09YmuX1QwX4XSyI84q5g';

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel =
        await YoutubeAPIService.instance.fetchChannel(channelId: channelID);
    setState(() {
      this._channel = channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          //color: kScaffoldBackgroundColor,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color(0xffe8e0d1),
          //       kScaffoldBackgroundColor
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     stops:[0.01,0.2]
          //   )
          // ),
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
                          padding: const EdgeInsets.only(top: 32),
                          child: Container(
                            height: 80,
                            width: 80,
                            child:
                                Image.asset('assets/images/logo_transparent.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 22.0, left: 12),
                          child: Container(
                            child: Text(
                              'Play',
                              style: kOnBoardingTitleStyle.copyWith(fontSize: 38),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 22),
                      child: Container(
                        child: Icon(
                          Icons.search,
                          size: 36,
                          color: kAmberColor,
                        ),
                      ),
                    )
                  ],
                ),
                buildAmberDivider(),
                FutureBuilder(
                  future: _getUserName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('');
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 0.0),
                        child: Container(
                          child: Text(
                            'Hi ${snapshot.data.toString()},\nContinue Watching >',
                            style: kOnBoardingTitleStyle,
                          ),
                        ),
                      );
                    }
                  },
                ),
                buildAmberDivider(),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                  child: Container(
                    height: size.height / 4,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: kScaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5.0,
                        ),
                        child: FutureBuilder(
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            Video video = _channel!.videos![0];
                            return Container(
                              height: double.infinity,
                                width: double.infinity,
                                child: Image.network(
                              video.thumbnailUrl!,
                              fit: BoxFit.fill,
                            ));
                          },
                        )),
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
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        iconSize: 28,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 22,
        curve: Curves.easeIn,
        backgroundColor: kScaffoldBackgroundColor,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        onItemSelected: (index) => setState(() => _currentIndex = index),
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
}
