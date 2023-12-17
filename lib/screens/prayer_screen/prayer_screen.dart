import 'package:christabodenew/core/enum/content_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/prayer_provider.dart';
import '../../providers/unsplash_image_provider.dart';
import '../global_components/content.dart';


class PrayerScreen extends StatefulWidget {
  static const id = "prayer_screen";
  final bool isCalledFromNavBar;

  static Route route() {
    return MaterialPageRoute(builder: (context) => const PrayerScreen());
  }

  const PrayerScreen({super.key, this.isCalledFromNavBar = false});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen>
{
  late final PageController _prayerPageController;

  int currentIndex = 0;



  @override
  void didChangeDependencies() {
    _prayerPageController = PageController(
        initialPage: context.watch<PrayerProvider>().currentPrayerIndex);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
_prayerPageController.dispose();
super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer2<PrayerProvider, UnsplashImageProvider>(
      builder: ((context, prayerData, unsplashImageData, child) {
        final UnsplashImage featuredImage =
            unsplashImageData.prayerFeaturedImage;
        return Scaffold(
          body: PageView.builder(
            controller: _prayerPageController,
            itemCount: prayerData.allPrayers.length,
            onPageChanged: (index) async {
              currentIndex = index;
              prayerData.updateCurrentPrayerIndex(index);
            },
            itemBuilder: (context, index) {
              Prayer prayer = prayerData.allPrayers[index];
              return Content(
                contentType: ContentType.prayer,
                title: prayer.title,
                content: prayer.content,
                featuredImage: featuredImage,
                scripture: prayer.scripture,
                scriptureReference: prayer.scriptureReference,
                startDate: prayer.date,
                isLiked: prayer.isLiked,
                onLikeButtonPressed: () {
                  prayerData.toggleLikedPrayer(index);
                },
                onNextButtonPressed: () {
                  _prayerPageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
                onPreviousButtonPressed: () {
                  _prayerPageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
              );
            },
          ),
        );
      }),
    );
  }
}
