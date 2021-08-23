import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:play_app/screens/preview_page.dart';
import 'package:play_app/services/video_streaming_service.dart';
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
  Widget searchContainer = Container();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kScaffoldBackgroundColor,
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
                  padding: const EdgeInsets.only(top: 31.0, left: 12),
                  child: Container(
                    child: Text(
                      'Watchtime',
                      style:
                      kOnBoardingTitleStyle.copyWith(fontSize: 48, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height / 2 - 50,
              width: size.width,
              child: FloatingSearchBar(
                //backgroundColor: kScaffoldBackgroundColor,
                backdropColor: kScaffoldBackgroundColor,
                iconColor: kLightPurpleColor,
                accentColor: kLightPurpleColor,
                hint: 'Search Videos',
                scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
                transitionDuration: const Duration(milliseconds: 800),
                transitionCurve: Curves.easeInOut,
                physics: const BouncingScrollPhysics(),
                axisAlignment: widget.isPortrait ? 0.0 : -1.0,
                openAxisAlignment: 0.0,
                width: widget.isPortrait ? 600 : 500,
                debounceDelay: const Duration(milliseconds: 500),
                onQueryChanged: (query) {},
                onSubmitted: (searchString){
                  // Search Logic
                  String? imageUrl = VideoStreamingService.search(searchString);
                  if (imageUrl != null){
                    setState(() {
                      searchContainer = _buildVideo(imageUrl, false);
                    });
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
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
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
