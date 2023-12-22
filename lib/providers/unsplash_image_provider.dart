import 'package:christabodenew/repositories/unsplash_image_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/core.dart';
import '../models/unsplash_image.dart';



class UnsplashImageProvider extends ChangeNotifier {
  final UnsplashImageRepository unsplashImageRepository;
  AppState state = AppState.initial;
  String errorMessage = "";
  List<UnsplashImage> featuredImages = [];
  UnsplashImage devotionalFeaturedImage = UnsplashImage.empty;
  UnsplashImage hymnFeaturedImage = UnsplashImage.empty;
  UnsplashImage prayerFeaturedImage = UnsplashImage.empty;
  UnsplashImage eventFeaturedImage = UnsplashImage.empty;

  UnsplashImageProvider({required this.unsplashImageRepository});


  Future<void> getFeaturedImages() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();
    Either<Failure, List<UnsplashImage>> response =
        await unsplashImageRepository.getRandomImage();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting the featured images";
      state = AppState.error;
    }, (images) {
      featuredImages = images;
      devotionalFeaturedImage = featuredImages[0];
      prayerFeaturedImage = featuredImages[1];
      eventFeaturedImage = featuredImages[2];
      hymnFeaturedImage = featuredImages[3];

      state = AppState.success;
    });

    notifyListeners();
  }

}
