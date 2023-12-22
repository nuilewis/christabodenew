import 'package:christabodenew/core/errors/exceptions.dart';
import 'package:christabodenew/models/unsplash_image.dart';
import 'package:christabodenew/services/unsplash/unsplash_api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/errors/failure.dart';
import '../services/unsplash/unsplash_hive_service.dart';

class UnsplashImageRepository {
  final UnsplashAPIClient apiClient;
  final UnsplashHiveService unsplashHiveService;
  List<UnsplashImage> _imagesList = [];
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  UnsplashImageRepository({
    required this.apiClient,
    required this.unsplashHiveService,
  });

  Future<Either<Failure, UnsplashImage>> getImage(String category) async {
    try {
      final UnsplashImage unsplashImage = await apiClient.getImage(category);
      return right(unsplashImage);
    } on ApiException catch (e) {
      debugPrint(e.toString());
      return Left(Failure(errorMessage: e.errorMessage));
    }
  }

  Future<Either<Failure, List<UnsplashImage>>> getRandomImage() async {
    final Box unsplashBox = await unsplashHiveService.openBox();
    _imagesList = await unsplashHiveService.getData(unsplashBox);

    if (_imagesList.isNotEmpty &&
        _imagesList.first.date?.month == _today.month &&
        _imagesList.first.date?.day == _today.day) {
      ///This is the case where we have images that were gotten today;
      ///Do not send a request again, and rather use those;
      debugPrint(
          "Getting Images from cache rather, and not from remote, as previous images were gotten today");
      return Right(_imagesList);
    } else {
      try {
        final List<UnsplashImage> images = await apiClient.getRandomImage();

        ///Save the featured images to local storage
        await unsplashHiveService.addImage(unsplashBox, images);
        return right(images);
      } on ApiException catch (e) {
        debugPrint(e.toString());
        return Left(Failure(errorMessage: e.errorMessage));
      }
    }
  }
}
