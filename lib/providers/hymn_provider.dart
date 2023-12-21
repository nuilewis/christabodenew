import 'package:christabodenew/repositories/hymn_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../core/core.dart';
import '../models/models.dart';


class HymnProvider extends ChangeNotifier {
  final HymnRepository hymnRepository;
  AppState state = AppState.initial;
  String? errorMessage;
  List<Hymn> allHymns = [];
  List<Hymn> likedHymns = [];

  int currentHymnIndex = 0;

  HymnProvider({required this.hymnRepository});


  void setHymnIndex(int index){
    currentHymnIndex = index;
    notifyListeners();
  }

  


  Future<void> getHymns() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    //notifyListeners();

    Either<Failure, List<Hymn>> response =
    await hymnRepository.getHymn();

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      print("an error occurred while making hymns");
      print(errorMessage);
      state = AppState.error;
    }, (hymns) {
      allHymns = hymns;
      print("gotten hymns");
      print(allHymns);
      state = AppState.success;
    });
    notifyListeners();
  }

  Future<void> getLikedHymn() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();
    Either<Failure, List<Hymn>> response =
    await hymnRepository.getLikedHymns();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting your favourite Hymn";

      state = AppState.error;
    }, (likedHymn) {
      likedHymns = likedHymn;
      state = AppState.success;
    });

    notifyListeners();
  }

  ///Used for both liking and unliking devotionals, as well as any
  ///other updates to the devotional list that is necessary
  Future<void> updateHymnList(List<Hymn> updatedList) async {
    Either<Failure, void> response =
    await hymnRepository.updateHymnSavedList(updatedList);
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Hymn";
      state = AppState.error;
    }, (nothing) {
      state = AppState.success;
    });
    notifyListeners();
  }

  Future<void> clearHymn() async {
    Either<Failure, void> response = await hymnRepository.clearHymn();
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Hymn";
      state = AppState.error;
    }, (nothing) {
      state = AppState.success;
    });
    notifyListeners();
  }

  Future<void> toggleLikedHymn(int index) async {
    if (allHymns.isNotEmpty) {
      ///This sets [isLiked] to be the opposite of what is the current value
      Hymn updatedHymn =
      allHymns[index].copyWith(isLiked: !allHymns[index].isLiked);
      List<Hymn> updatedList = allHymns;
      updatedList.removeAt(index);
      updatedList.insert(index, updatedHymn);

      await updateHymnList(updatedList);
      await getLikedHymn();
      state = AppState.success;
    } else {
      state = AppState.error;
    }
    notifyListeners();
  }

  Future<void> initialise() async {
    await getHymns().whenComplete(() async{await getLikedHymn();});

  }

  void shareHymn(Hymn hymn) async{

    String constructedText ="""
*${hymn.title.trim()}*

${hymn.content.trim()}

*Christ Abode Ministries*

www.christabodeministries.org
Shared from the Christ Abode Ministries App
Available on the Google Play Store""";

    await Share.share(constructedText);
  }
}
