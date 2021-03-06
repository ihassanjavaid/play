import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:play_app/screens/login_screen.dart';
import 'package:play_app/utilities/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'on_boarding_screen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? kTealColor : kTealColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: kScaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, LoginScreen.id);
                    },
                    child: Text('Skip', style: kBottomNavBarTextStyle),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: 460.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      buildPageViewBlock(
                          'Binge-Worthy\nContent, All day long!',
                          'All your favourite shows, movies and dramas, right in the palm of your hand, just a tap away',
                          'assets/images/logo_transparent.png'),
                      buildPageViewBlock(
                          'Adaptive\nStreaming\tQuality!',
                          'Faciliting users with all types of internet connection, whether you\'re on 2G watching news, or streaming 4K content on LTE',
                          'assets/images/logo_transparent.png'),
                      buildPageViewBlock(
                          'Up to 4K\nVideo Quality',
                          'Never miss a frame, or a grain of detail, with 4K Ultra high definition video streaming',
                          'assets/images/logo_transparent.png'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _currentPage != _numPages - 1
                              ? _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease)
                              : Navigator.popAndPushNamed(context, LoginScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                    _currentPage != _numPages - 1
                                        ? 'Next'
                                        : 'Get Started',
                                    style: kBottomNavBarTextStyle),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: kTealColor,
                                size: 30.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageViewBlock(String mainText, String subText, String image) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 130,
              width: 130,
              child: FittedBox(
                child: Image.asset(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 2.0,
              width: 300.0,
              color: kAmberColor,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            mainText,
            style: kOnBoardingTitleStyle,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            subText,
            style: kOnBoardingSubtitleStyle,
          ),
        ],
      ),
    );
  }
}
