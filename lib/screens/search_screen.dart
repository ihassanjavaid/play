import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:play_app/models/channel_model.dart';
import 'package:play_app/models/video_model.dart';
import 'package:play_app/screens/video_screen.dart';
import 'package:play_app/services/firestore_video_service.dart';
import 'package:play_app/services/youtube_api_service.dart';
import 'package:play_app/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "search_screen";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: BuildSearchBar(isPortrait: isPortrait),
    );
  }
}

class BuildSearchBar extends StatefulWidget {
  const BuildSearchBar({
    Key? key,
    required this.isPortrait,
  }) : super(key: key);

  final bool isPortrait;

  @override
  _BuildSearchBarState createState() => _BuildSearchBarState();
}

class _BuildSearchBarState extends State<BuildSearchBar> {
  Channel? _channel;
  bool _isLoading = false;
  FirestoreVideoService _firestoreVideoService = FirestoreVideoService();

  final ScrollController _scrollController = ScrollController();

  String channelID = 'UCVD09YmuX1QwX4XSyI84q5g';

  Widget searchContainer = Container();

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
    String? _query;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (_channel != null) {
            return Container(
              color: kScaffoldBackgroundColor,
              height: size.height - 50,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Container(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                              'assets/images/logo_transparent.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22.0, left: 12),
                        child: Container(
                          child: Text(
                            'Play',
                            style:
                            kOnBoardingTitleStyle.copyWith(fontSize: 38),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                    width: size.width,
                    child: FloatingSearchBar(
                      backgroundColor: kLightAmberColor,
                      backdropColor: kScaffoldBackgroundColor,
                      iconColor: kTealColor,
                      accentColor: kTealColor,
                      hint: 'Search YouTube',
                      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
                      transitionDuration: const Duration(milliseconds: 800),
                      transitionCurve: Curves.easeInOut,
                      physics: const BouncingScrollPhysics(),
                      axisAlignment: widget.isPortrait ? 0.0 : -1.0,
                      openAxisAlignment: 0.0,
                      width: widget.isPortrait ? 600 : 500,
                      debounceDelay: const Duration(milliseconds: 500),
                      onQueryChanged: (query) {
                        _query = query;
                      },
                      onSubmitted: (searchString){
                        // Search Logic
                        Video i;
                        if (_channel != null){
                          for (i in _channel!.videos!){
                            if (i.title!.contains(searchString)) {
                              print('here');
                              setState(() {
                                searchContainer = _buildVideo(i);
                              });
                            }
                          }
                        }
                      },
                      transition: CircularFloatingSearchBarTransition(),
                      actions: [
                        FloatingSearchBarAction(
                          showIfOpened: false,
                          child: CircularButton(
                            icon: const Icon(Icons.video_call),
                            onPressed: () {},
                          ),
                        ),
                        FloatingSearchBarAction.searchToClear(
                          color: kScaffoldBackgroundColor,
                          showIfClosed: false,
                        ),
                      ],
                      builder: (context, transition) {
                        return searchContainer;
                      },
                    ),
                  )
                ],
              ),
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: kTealColor,
                color: kAmberColor,
              ),
            );
          }
        }
      ),
    );
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
