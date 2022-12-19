import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/screens/global_components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';

class FavouritesScreen extends StatefulWidget {
  static const id = "favourite_screen.dart";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const FavouritesScreen());
  }

  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DevotionalProvider>(
        builder: (context, devotionalData, child) {
      // devotionalData.getLikedDevotionals();
      return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  "Favourites",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  height: kDefaultPadding2x,
                ),
                const SizedBox(height: kDefaultPadding),
                devotionalData.likedDevotionals.isNotEmpty
                    ? ListView.builder(
                        itemCount: devotionalData.likedDevotionals.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                devotionalData.likedDevotionals[index].title),
                          );
                        })
                    : Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/heart_icon.svg",
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.3),
                                width: MediaQuery.of(context).size.width * .3,
                              ),
                              const SizedBox(height: kDefaultPadding2x),
                              Text(
                                "You haven't liked any Huios Epistolary Devotional message yet, once you do so, they'll appear here",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: kDefaultPadding2x),
                const SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ),
      );
    });
  }
}
