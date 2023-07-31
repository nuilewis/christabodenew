import 'package:christabodenew/core/errors/failure.dart';
import 'package:christabodenew/repositories/unsplash_image_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../models/unsplash_image.dart';

enum UnsplashImageState { initial, submitting, success, error }

class UnsplashImageProvider extends ChangeNotifier {
  final UnsplashImageRepository unsplashImageRepository;
  UnsplashImageState state = UnsplashImageState.initial;
  String errorMessage = "";
  UnsplashImage devotionalFeaturedImage = UnsplashImage.empty;
  UnsplashImage prayerFeaturedImage = UnsplashImage.empty;
  UnsplashImage eventFeaturedImage = UnsplashImage.empty;

  UnsplashImageProvider({required this.unsplashImageRepository});

  // Future<void> getDevotionalFeaturedImage(String category) async {
  //   if (state == UnsplashImageState.submitting) return;
  //   state = UnsplashImageState.submitting;
  //   notifyListeners();
  //   Either<Failure, UnsplashImage> response =
  //       await unsplashImageRepository.getImage(category);
  //
  //   response.fold((failure) {
  //     errorMessage = failure.errorMessage ??
  //         "An error occurred while getting the featured image";
  //     state = UnsplashImageState.error;
  //   }, (image) {
  //     devotionalFeaturedImage = image;
  //     state = UnsplashImageState.success;
  //   });
  //
  //   notifyListeners();
  // }

  Future<void> getFeaturedImages() async {
    await getDevotionalFeaturedImage();
    await getPrayerFeaturedImage();
    await getEventFeaturedImage();
  }

  Future<void> getDevotionalFeaturedImage() async {
    if (state == UnsplashImageState.submitting) return;
    state = UnsplashImageState.submitting;
    notifyListeners();
    Either<Failure, UnsplashImage> response =
        await unsplashImageRepository.getRandomImage();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting the featured image";
      state = UnsplashImageState.error;
    }, (image) {
      devotionalFeaturedImage = image;
      state = UnsplashImageState.success;
    });

    notifyListeners();
  }

  Future<void> getEventFeaturedImage() async {
    if (state == UnsplashImageState.submitting) return;
    state = UnsplashImageState.submitting;
    notifyListeners();
    Either<Failure, UnsplashImage> response =
        await unsplashImageRepository.getRandomImage();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting the featured image";
      state = UnsplashImageState.error;
    }, (image) {
      eventFeaturedImage = image;
      state = UnsplashImageState.success;
    });

    notifyListeners();
  }

  Future<void> getPrayerFeaturedImage() async {
    if (state == UnsplashImageState.submitting) return;
    state = UnsplashImageState.submitting;
    notifyListeners();
    Either<Failure, UnsplashImage> response =
        await unsplashImageRepository.getRandomImage();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting the featured image";
      state = UnsplashImageState.error;
    }, (image) {
      prayerFeaturedImage = image;
      state = UnsplashImageState.success;
    });

    notifyListeners();
  }
}
