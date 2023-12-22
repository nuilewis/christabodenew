import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:christabodenew/screens/global_components/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';

import 'package:christabodenew/core/core.dart';

class DevotionalScreen extends StatefulWidget {
  static const id = "devotional_screen";
  final bool isCalledFromNavBar;

  static Route route() {
    return MaterialPageRoute(builder: (context) => const DevotionalScreen());
  }

  const DevotionalScreen({super.key, this.isCalledFromNavBar = false});

  @override
  State<DevotionalScreen> createState() => _DevotionalScreenState();
}

class _DevotionalScreenState extends State<DevotionalScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _devotionalPageController;

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    _devotionalPageController = PageController(
        initialPage:
            context.watch<DevotionalProvider>().currentDevotionalIndex);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _devotionalPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DevotionalProvider, UnsplashImageProvider>(
      builder: (context, devotionalData, unsplashImageData, child) {
        final UnsplashImage featuredImage =
            unsplashImageData.devotionalFeaturedImage;

        return Scaffold(
          body: PageView.builder(
            controller: _devotionalPageController,
            itemCount: devotionalData.allDevotionals.length,
            onPageChanged: (index) async {
              currentIndex = index;
              devotionalData.updateCurrentDevotionalIndex(index);
            },
            itemBuilder: (context, index) {
              Devotional devotional = devotionalData.allDevotionals[index];
              return Content(
                onShareButtonPressed:() async {
                  devotionalData.shareDevotional(context, devotional);

                },
                contentType: ContentType.devotional,
                title: devotional.title,
                content: devotional.content,
                isLiked: devotional.isLiked,
                author: devotional.author,
                startDate: devotional.startDate,
                endDate: devotional.endDate,
                confessionOfFaith: devotional.confessionOfFaith,
                scripture: devotional.scripture,
                scriptureReference: devotional.scriptureReference,
                featuredImage: featuredImage,
                onLikeButtonPressed: () {
                  devotionalData.toggleLikedDevotional(index);
                },
                onNextButtonPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  _devotionalPageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
                onPreviousButtonPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  _devotionalPageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
              );
            },
          ),
        );
      },
    );
  }
}
