import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/unsplash_image.dart';
import '../../providers/prayer_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/unsplash_image_provider.dart';
import '../devotional_screen/components/featured_image.dart';
import 'components/prayer_content.dart';

//
// class PrayerScreen extends StatefulWidget {
//   static const id = "prayer_screen.dart";
//   static Route route(){return MaterialPageRoute(builder: (context)=>const PrayerScreen());}
//
//   final bool isCalledFromNavBar;
//   const PrayerScreen({super.key, this.isCalledFromNavBar=false});
//
//   @override
//   State<PrayerScreen> createState() => _PrayerScreenState();
// }
//
// class _PrayerScreenState extends State<PrayerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class PrayerScreen extends StatefulWidget {
  static const id = "prayer_screen.dart";
  final bool isCalledFromNavBar;

  static Route route() {
    return MaterialPageRoute(builder: (context) => const PrayerScreen());
  }

  const PrayerScreen({Key? key, this.isCalledFromNavBar = false})
      : super(key: key);

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _prayerPageController;

  late final AnimationController scrollAnimationController;
  late final Animation<Color?> colorAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    scrollAnimationController = AnimationController(
      lowerBound: 0,
      upperBound: 180,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    colorAnimation = ColorTween(begin: Colors.white, end: kDark)
        .animate(scrollAnimationController);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _prayerPageController = PageController(
        initialPage: context.watch<PrayerProvider>().currentPrayerIndex);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _prayerPageController.dispose();
    scrollAnimationController.dispose();

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
                                    : colorAnimation.value!,
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
                              prayerData.allPrayers[index].title.toTitleCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
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
                      child: PrayerContent(
                    prayer: prayerData.allPrayers[index],
                    onNextButtonPressed: () {
                      _prayerPageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    onPreviousButtonPressed: () {
                      _prayerPageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    onLikedButtonPressed: () {
                      prayerData.toggleLikedPrayer(index);
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
