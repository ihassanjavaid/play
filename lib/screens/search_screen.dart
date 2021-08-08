import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({
    Key? key,
    required this.isPortrait,
  }) : super(key: key);

  final bool isPortrait;

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
                      'Play',
                      style:
                      kOnBoardingTitleStyle.copyWith(fontSize: 48, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height / 2,
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
                axisAlignment: isPortrait ? 0.0 : -1.0,
                openAxisAlignment: 0.0,
                width: isPortrait ? 600 : 500,
                debounceDelay: const Duration(milliseconds: 500),
                onQueryChanged: (query) {},
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: kScaffoldBackgroundColor,
                      elevation: 4.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: Colors.accents.map((color) {
                          return Container(height: 112, color: color);
                        }).toList().sublist(0, 3),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
