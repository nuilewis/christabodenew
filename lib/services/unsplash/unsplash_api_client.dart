import 'dart:math';

import 'package:christabodenew/models/unsplash_image.dart';
import 'package:christabodenew/services/unsplash/.env.dart';
import 'package:dio/dio.dart';

import '../../core/errors/exceptions.dart';

const String _baseUrl = "https://api.unsplash.com/";
const String _randomImageEndpoint = "/photos/random";
const String _imageEndpoint = "";

class UnsplashAPIClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      responseType: ResponseType.json,
      headers: {
        "Authorization": "Client-ID $unsplashAccessKey",
        "Accept-Version": "v1",
      },
    ),
  );
  Future<UnsplashImage> getRandomImage() async {
    try {
      final response = await _dio.get(_randomImageEndpoint, queryParameters: {
        "query": " ${photoCategories[Random().nextInt(18)]}"
      });

      ///Randomly picks from any of the categories each time
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = response.data;

        final UnsplashImage image = UnsplashImage.fromJson(responseJson);
        return image;
      } else {
        DioError dioError = DioError(
            requestOptions:
                RequestOptions(path: "$_baseUrl$_randomImageEndpoint"));
        final ApiException exception =
            ApiException(errorMessage: dioError.message);
        throw exception;
      }
    } on DioError catch (e) {
      final ApiException exception = ApiException(errorMessage: e.message);
      throw exception;
    }
  }

  Future<UnsplashImage> getImage(String category) async {
    try {
      final response = await _dio.get(_imageEndpoint);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = response.data;

        final UnsplashImage image = UnsplashImage.fromJson(responseJson);
        return image;
      } else {
        DioError dioError = DioError(
            requestOptions:
                RequestOptions(path: "$_baseUrl$_randomImageEndpoint"));
        final ApiException exception =
            ApiException(errorMessage: dioError.message);
        throw exception;
      }
    } on DioError catch (e) {
      final ApiException exception = ApiException(errorMessage: e.message);
      throw exception;
    }
  }

  Map<int, String> photoCategories = {
    0: "green grass",
    1: "mountains",
    2: "trees",
    3: "water",
    4: "ocean",
    5: "forest",
    6: "church",
    7: "oceans",
    8: "clouds",
    9: "waterfall",
    10: "landscape",
    11: "snow",
    12: "ice",
    13: "landscape nature",
    14: "flowers",
    15: "leaves",
    16: "rocks",
    17: "lakes",
    18: "foam water",
  };
}
