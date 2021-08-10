import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_app/models/common/data.dart';
import 'package:play_app/utilities/constants.dart';
import 'package:play_app/widgets/info_tile.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  final Data assetData;

  const PreviewPage({required this.assetData});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  VideoPlayerController? _controller;
  Data? assetData;
  String? dateTimeString;

  @override
  void initState() {
    super.initState();

    assetData = widget.assetData;
    String playbackId = assetData!.playbackIds![0]!.id;
    String? assetDataCreated = assetData!.createdAt;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(assetDataCreated!) * 1000);
    DateFormat formatter = DateFormat.yMd().add_jm();
    dateTimeString = formatter.format(dateTime);

    _controller = VideoPlayerController.network(
        '$muxStreamBaseUrl/$playbackId.$videoExtension');
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    await _controller?.initialize();
    /*setState(() {});*/
    _controller?.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: kPurpleColor,
        child: Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    width: double.maxFinite,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.muxPink,
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
                _controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(_controller!),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  VideoPlayerControl(
                                    icon: Icons.play_arrow,
                                    callback: () {
                                      _controller?.play();
                                    },
                                  ),
                                  VideoPlayerControl(
                                    icon: Icons.pause,
                                    callback: () {
                                      _controller?.pause();
                                    },
                                  ),
                                  VideoPlayerControl(
                                    icon: Icons.stop,
                                    callback: () {
                                      _controller?.seekTo(Duration(seconds: 0));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    VideoPlayerControl(
                                      icon: Icons.fast_rewind,
                                      callback: () async {
                                        final pos = await _controller?.position;
                                        _controller?.seekTo(Duration(seconds: pos!.inSeconds - 3));
                                        },
                                    ),
                                    VideoPlayerControl(
                                      icon: Icons.fast_forward,
                                      callback: () async {
                                        final pos = await _controller?.position;
                                        _controller?.seekTo(Duration(seconds: pos!.inSeconds + 3));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: Colors.black,
                          width: double.maxFinite,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                kPurpleColor,
                              ),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoTile(
                    name: 'Asset ID',
                    data: assetData!.id,
                  ),
                  InfoTile(
                    name: 'Created',
                    data: dateTimeString,
                  ),
                  InfoTile(
                    name: 'Status',
                    data: assetData!.status,
                  ),
                  InfoTile(
                    name: 'Duration',
                    data: '${assetData!.duration!.toStringAsFixed(2)} seconds',
                  ),
                  InfoTile(
                    name: 'Max Resolution',
                    data: assetData!.maxStoredResolution,
                  ),
                  InfoTile(
                    name: 'Max Frame Rate',
                    data: assetData!.maxStoredFrameRate.toString(),
                  ),
                  InfoTile(
                    name: 'Aspect Ratio',
                    data: assetData!.aspectRatio,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlayerControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback callback;

  const VideoPlayerControl({
    Key? key,
    required this.icon,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        this.icon,
        color: Colors.white,
        size: 30,
      ),
      onTap: callback,
    );
  }
}
