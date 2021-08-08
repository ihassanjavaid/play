import 'package:dio/dio.dart';
import 'package:play_app/models/asset_data.dart';
import 'package:play_app/models/video_data.dart';
import 'package:play_app/utilities/constants.dart';


class MUXClient {
  Dio _dio = Dio();

  /// Method for configuring Dio, the authorization is done from
  /// the API server
  initializeDio() {
    BaseOptions options = BaseOptions(
      baseUrl: muxServerUrl,
      connectTimeout: 8000,
      receiveTimeout: 5000,
      headers: {
        "Content-Type": contentType, // application/json
      },
    );
    _dio = Dio(options);
  }

  /// Method for storing a video to MUX, by passing the [videoUrl].
  ///
  /// Returns the `VideoData`.
  Future<VideoData?> storeVideo({required String videoUrl}) async {
    Response response;

    try {
      response = await _dio.post(
        "/assets",
        data: {
          "videoUrl": videoUrl,
        },
      );
    } catch (e) {
      print('Error starting build: $e');
      throw Exception('Failed to store video on MUX');
    }

    if (response.statusCode == 200) {
      VideoData? videoData = VideoData.fromJson(response.data);

      String? status = videoData.data!.status;

      while (status == 'preparing') {
        print('check');
        await Future.delayed(Duration(seconds: 1));
        videoData = await checkPostStatus(videoId: videoData!.data!.id!);
        status = videoData!.data!.status;
      }

      // print('Video READY, id: ${videoData.data.id}');

      return videoData;
    }

    return null;
  }

  /// Method for tracking the status of video storage on MUX.
  ///
  /// Returns the `VideoData`.
  Future<VideoData?> checkPostStatus({required String videoId}) async {
    try {
      Response response = await _dio.get(
        "/asset",
        queryParameters: {
          'videoId': videoId,
        },
      );

      if (response.statusCode == 200) {
        VideoData videoData = VideoData.fromJson(response.data);

        return videoData;
      }
    } catch (e) {
      print('Error starting build: $e');
      throw Exception('Failed to check status');
    }

    return null;
  }

  /// Method for retrieving the entire asset list.
  ///
  /// Returns the `AssetData`.
  Future<AssetData>? getAssetList() async {
    try {
      Response response = await _dio.get(
        "/assets",
      );
      print("Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        AssetData assetData = AssetData.fromJson(response.data);
        return assetData;
      }
      print('here, no exception');
    } catch (e) {
      print('Error starting build: $e');
      throw Exception('Failed to retrieve videos');
    }

    return AssetData(data: []);
  }
}
