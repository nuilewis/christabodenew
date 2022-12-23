import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/unsplash_image.dart';
import 'components/devotional_content.dart';

class DevotionalScreen extends StatefulWidget {
  static const id = "devotional_screen";
  final bool isCalledFromNavBar;

  static Route route() {
    return MaterialPageRoute(builder: (context) => const DevotionalScreen());
  }

  const DevotionalScreen({Key? key, this.isCalledFromNavBar = false})
      : super(key: key);

  @override
  State<DevotionalScreen> createState() => _DevotionalScreenState();
}

class _DevotionalScreenState extends State<DevotionalScreen> {
  late final PageController _devotionalPageController;

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    _devotionalPageController = PageController(
        initialPage: context.watch<DevotionalProvider>().todaysDevotionalIndex);

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
      builder: ((context, devotionalData, unsplashImageData, child) {
        final UnsplashImage featuredImage = unsplashImageData.featuredImage;
        return Scaffold(
          body: PageView.builder(
            controller: _devotionalPageController,
            itemCount: devotionalData.allDevotionals.length,
            onPageChanged: (index) async {
              currentIndex = index;
              await unsplashImageData.getRandomImage();
            },
            itemBuilder: (context, index) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle.light,
                    collapsedHeight: 80,
                    leading: widget.isCalledFromNavBar
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              "assets/svg/back_icon.svg",
                              color: Colors.white,
                            ),
                          ),
                    floating: true,
                    pinned: true,
                    //centerTitle: true,
                    // title: Text(
                    //   "Devotional page",
                    //   style: Theme.of(context).textTheme.headline1,
                    // ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.all(kDefaultPadding),
                      expandedTitleScale: 1,
                      title: Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding2x),
                          child: Text(
                            devotionalData.allDevotionals[index].title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      background: Stack(
                        children: [
                          SizedBox.expand(
                            child: BlurHash(
                              imageFit: BoxFit.cover,
                              image: featuredImage.imgUrl,
                              hash: featuredImage.blurHash,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.2),
                            ),
                          ),
                          Positioned(
                            right: kDefaultPadding,
                            bottom: kDefaultPadding,
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Image by ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.white.withOpacity(.7),
                                            fontSize: 9)),
                                TextSpan(
                                    text: featuredImage.uploaderName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Colors.white.withOpacity(.7),
                                            fontSize: 9)),
                                TextSpan(
                                    text: " - Unsplash",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.white.withOpacity(.7),
                                            fontSize: 9))
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    expandedHeight: 300,
                  ),
                  SliverToBoxAdapter(
                      child: DevotionalContent(
                    currentDevotional: devotionalData.allDevotionals[index],
                    onNextButtonPressed: () {
                      _devotionalPageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    onPreviousButtonPressed: () {
                      _devotionalPageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    onLikedButtonPressed: () {
                      devotionalData.toggleLikedDevotional(index);
                    },
                    onShareButtonPressed: () {
                      ///Todo: implement a sharing feature
                    },
                  ))
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
