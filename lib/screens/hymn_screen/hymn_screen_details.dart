import 'dart:ui';

import 'package:christabodenew/providers/hymn_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';

import 'package:christabodenew/core/core.dart';

class HymnScreenDetails extends StatefulWidget {
  static const id = "hymn_screen_details";
  final bool isCalledFromNavBar;
  final int? index;

  static Route route() {
    return MaterialPageRoute(builder: (context) => const HymnScreenDetails());
  }

  const HymnScreenDetails(
      {super.key, this.isCalledFromNavBar = false, this.index});

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
        initialPage: context.watch<HymnProvider>().currentHymnIndex);

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
        final UnsplashImage featuredImage = unsplashImageData.hymnFeaturedImage;

        return Scaffold(
          body: PageView.builder(
            controller: _hymnPageController,
            itemCount: hymnData.allHymns.length,
            onPageChanged: (index) async {
              currentIndex = index;
              hymnData.setHymnIndex(index);
            },
            itemBuilder: (context, index) {
              Hymn hymn = hymnData.allHymns[index];
              return HymnContent(
                onShareButtonPressed: () {
                  hymnData.shareHymn(hymn);
                },
                onNextButtonPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  _hymnPageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
                onPreviousButtonPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  _hymnPageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                },
                onLikeButtonPressed: () {
                  hymnData.toggleLikedHymn(index);
                },
                hymn: hymn,
                featuredImage: featuredImage,
              );
              // return Content(
              //   onShareButtonPressed:(){
              //     hymnData.shareHymn(hymn);
              //   },
              //   contentType: ContentType.hymn,
              //   title: hymn.title,
              //   content: hymn.content,
              //   isLiked: hymn.isLiked,
              //   featuredImage: featuredImage,
              //   onLikeButtonPressed: () {
              // hymnData.toggleLikedHymn(index);
              //   },
              //   onNextButtonPressed: () {
              //     HapticFeedback.lightImpact();
              //     Feedback.forTap(context);
              //     _hymnPageController.nextPage(
              //         duration: const Duration(milliseconds: 250),
              //         curve: Curves.easeInOut);
              //   },
              //   onPreviousButtonPressed: () {
              //     HapticFeedback.lightImpact();
              //     Feedback.forTap(context);
              //     _hymnPageController.previousPage(
              //         duration: const Duration(milliseconds: 250),
              //         curve: Curves.easeInOut);
              //   },
              // );
            },
          ),
        );
      },
    );
  }
}

class HymnContent extends StatelessWidget {
  final UnsplashImage featuredImage;
  final Hymn hymn;
  final VoidCallback onLikeButtonPressed;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onShareButtonPressed;
  final VoidCallback onPreviousButtonPressed;
  const HymnContent(
      {super.key,
      required this.hymn,
      required this.featuredImage,
      required this.onLikeButtonPressed,
      required this.onNextButtonPressed,
      required this.onShareButtonPressed,
      required this.onPreviousButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurHash(
          imageFit: BoxFit.cover,
          image: featuredImage.imgUrl,
          hash: featuredImage.blurHash,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaY: .5, sigmaX: .5),
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Color(0xFF07062C).withOpacity(.45),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(64),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(FluentIcons.arrow_left_24_regular)),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: IconButton.filled(
                            style: IconButton.styleFrom(
                              fixedSize: const Size(48, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              backgroundColor: AppColours.white.withOpacity(.3),
                            ),
                            onPressed: onShareButtonPressed,
                            icon: const Icon(
                                FluentIcons.share_android_24_regular)),
                      ),
                    ),
                    const Gap(12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: IconButton.filled(
                          style: IconButton.styleFrom(
                            fixedSize: const Size(48, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: AppColours.white.withOpacity(.3),
                          ),
                          onPressed: onLikeButtonPressed,
                          icon: Icon(hymn.isLiked
                              ? FluentIcons.heart_24_filled
                              : FluentIcons.heart_24_regular),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                Text(
                  hymn.number.toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Gap(32),
                Text(
                  hymn.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(height: 1.5),
                ),
                const Gap(32),
                Text(
                  hymn.content,
                  textAlign: TextAlign.center,
                ),
                const Gap(64),
              ],
            ),
          )),
        )
      ],
    );
  }
}
