import 'package:christabodenew/core/errors/exceptions.dart';
import 'package:christabodenew/models/unsplash_image.dart';
import 'package:christabodenew/services/unsplash/unsplash_api_client.dart';
import 'package:dartz/dartz.dart';

import '../core/connection_checker/connection_checker.dart';
import '../core/errors/failure.dart';

abstract class UnsplashImageRepository {
  Future<Either<Failure, UnsplashImage>> getRandomImage();
  Future<Either<Failure, UnsplashImage>> getImage(String category);
}

class UnsplashImageRepositoryImplementation implements UnsplashImageRepository {
  final UnsplashAPIClient apiClient;
  final ConnectionChecker connectionChecker;

  UnsplashImageRepositoryImplementation(
      {required this.apiClient, required this.connectionChecker});

  @override
  Future<Either<Failure, UnsplashImage>> getImage(String category) async {
    if (await connectionChecker.isConnected) {
      try {
        final UnsplashImage unsplashImage = await apiClient.getImage(category);
        return right(unsplashImage);
      } on ApiException catch (e) {
        return Left(ApiFailure(errorMessage: e.errorMessage));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UnsplashImage>> getRandomImage() async {
    if (await connectionChecker.isConnected) {
      try {
        final UnsplashImage unsplashImage = await apiClient.getRandomImage();
        return right(unsplashImage);
      } on ApiException catch (e) {
        return Left(ApiFailure(errorMessage: e.errorMessage));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
