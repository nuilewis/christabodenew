import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/unsplash_image.dart';
import '../../providers/settings_provider.dart';
import 'components/devotional_content.dart';
import 'components/featured_image.dart';

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

class _DevotionalScreenState extends State<DevotionalScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _devotionalPageController;

  late final AnimationController scrollAnimationController;
  late final Animation<Color?> colorAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    scrollAnimationController = AnimationController(
      lowerBound: 0,
      upperBound: 280,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    colorAnimation = ColorTween(begin: Colors.white, end: kDark)
        .animate(scrollAnimationController);

    super.initState();
  }

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
    scrollAnimationController.dispose();
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
            //allDevotionals is not actually all the devotionals but
            //it is all the devotionals right upto the today. Same with the prayers.
            onPageChanged: (index) async {
              currentIndex = index;
              devotionalData.updateCurrentDevotionalIndex(index);
              await unsplashImageData.getRandomImage();
            },
            itemBuilder: (context, index) {
              return CustomScrollView(
                slivers: [
                  SliverLayoutBuilder(
                      builder: (BuildContext context, constraints) {
                    ///280 because 280 is the scroll offset when the app is
                    ///fully scrolled to the collapsed state from the expanded state
                    ///And for any scroll above that, the value is permanently set to 1,
                    ///so the colour will always be black, at the max value.
                    ///
                    ///Though there is a slight issue when u have scrolled far above, and
                    ///start scrolling up again, the image shows up a bit too fast
                    ///and the black text doesn't fully transition to white, when the image
                    ///loads so u now have black text on a relatively blacker image
                    ///and u cannot see anything.
                    if (constraints.scrollOffset < 280) {
                      scrollAnimationController.value =
                          constraints.scrollOffset / 280;
                    } else {
                      scrollAnimationController.value = 1;
                    }

                    //print(constraints.scrollOffset);

                    return SliverAppBar(
                      onStretchTrigger: () async {
                        ///Todo: you cna put a method to refresh the page or soemthing lidat.
                        print("refreshing the page");
                      },
                      iconTheme: Theme.of(context).iconTheme,
                      // stretchTriggerOffset: 20,
                      surfaceTintColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                      collapsedHeight: 120,
                      leading: widget.isCalledFromNavBar
                          ? const SizedBox()
                          : IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                "assets/svg/back_icon.svg",

                                ///Check if it is in dark mode or light mode by checking the settings provider
                                ///and the isDarkMode variable. If true then always keep the text white,
                                ///if false (ie it is in light mode, )
                                ///then animate the text colour as user scrolls
                                color: Provider.of<SettingsProvider>(context)
                                        .userSettings
                                        .isDarkMode
                                    ? Colors.white
                                    : colorAnimation.value,
                              ),
                            ),
                      floating: true,
                      pinned: true,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        centerTitle: true,
                        titlePadding: const EdgeInsets.all(kDefaultPadding),
                        expandedTitleScale: 1,
                        title: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: kDefaultPadding2x),
                            child: Text(
                              devotionalData.allDevotionals[index].title
                                  .toTitleCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      color:
                                          Provider.of<SettingsProvider>(context)
                                                  .userSettings
                                                  .isDarkMode
                                              ? Colors.white
                                              : colorAnimation.value,
                                      fontSize: 24),
                            ),
                          ),
                        ),
                        background: Stack(
                          children: [
                            FeaturedImage(featuredImage: featuredImage),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 32,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft:
                                          Radius.circular(kDefaultPadding2x),
                                      topRight:
                                          Radius.circular(kDefaultPadding2x),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      expandedHeight: 300,
                    );
                  }),
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
