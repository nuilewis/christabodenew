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
      final response = await _dio.get(_randomImageEndpoint);

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
}
