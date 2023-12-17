import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/hymn_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:christabodenew/screens/global_components/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/models.dart';

import 'package:christabodenew/core/core.dart';

class HymnScreenDetails extends StatefulWidget {
  static const id = "hymn_screen_details";
  final bool isCalledFromNavBar;

  static Route route() {
    return MaterialPageRoute(builder: (context) => const HymnScreenDetails());
  }

  const HymnScreenDetails({super.key, this.isCalledFromNavBar = false});

  @override
  State<HymnScreenDetails> createState() => _HymnScreenDetailsState();
}

class _HymnScreenDetailsState extends State<HymnScreenDetails>
    with SingleTickerProviderStateMixin {
  late final PageController _hymnPageController;

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    _hymnPageController = PageController(
        initialPage:
        context.watch<DevotionalProvider>().currentDevotionalIndex);

    super.didChangeDependencies();
  }
  @override
  void dispose() {
_hymnPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HymnProvider, UnsplashImageProvider>(
      builder: (context, hymnData, unsplashImageData, child) {
        final UnsplashImage featuredImage =
            unsplashImageData.hymnFeaturedImage;

        return Scaffold(
          body: PageView.builder(
            controller: _hymnPageController,
            itemCount: hymnData.allHymns.length,
            onPageChanged: (index) async {
              currentIndex = index;
            },
            itemBuilder: (context, index) {
              Hymn hymn = hymnData.allHymns[index];
              return Content(
                contentType: ContentType.devotional,
                title: hymn.title,
                content: hymn.content,
                isLiked: hymn.isLiked,
                featuredImage: featuredImage,
                onLikeButtonPressed: () {
              hymnData.toggleLikedHymn(index);
                },
                onNextButtonPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  _hymnPageController.nextPage(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
                onPreviousButtonPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  _hymnPageController.previousPage(
                      duration: Duration(milliseconds: 250),
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
