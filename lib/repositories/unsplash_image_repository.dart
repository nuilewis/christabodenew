import 'package:christabodenew/core/errors/exceptions.dart';
import 'package:christabodenew/models/unsplash_image.dart';
import 'package:christabodenew/services/unsplash/unsplash_api_client.dart';
import 'package:dartz/dartz.dart';
import '../core/errors/failure.dart';

class UnsplashImageRepository {
  final UnsplashAPIClient apiClient;

  UnsplashImageRepository(
      {required this.apiClient});


  Future<Either<Failure, UnsplashImage>> getImage(String category) async {

      try {
        final UnsplashImage unsplashImage = await apiClient.getImage(category);
        return right(unsplashImage);
      } on ApiException catch (e) {
        return Left(Failure(errorMessage: e.errorMessage));
      }

  }

  Future<Either<Failure, UnsplashImage>> getRandomImage() async {

      try {
        final UnsplashImage unsplashImage = await apiClient.getRandomImage();
        return right(unsplashImage);
      } on ApiException catch (e) {
        return Left(Failure(errorMessage: e.errorMessage));
      }

  }
}
