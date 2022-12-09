import 'package:christabodenew/core/date_time_formatter.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/devotional_model.dart';
import '../../models/unsplash_image.dart';

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
  @override
  Widget build(BuildContext context) {
    return Consumer2<DevotionalProvider, UnsplashImageProvider>(
      builder: ((context, devotionalData, unsplashImageData, child) {
        Devotional currentDevotional =
            devotionalData.currentDevotional ?? Devotional.empty;
        final UnsplashImage featuredImage = unsplashImageData.featuredImage;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: 150,
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
                      padding: const EdgeInsets.only(top: kDefaultPadding2x),
                      child: Text(
                        currentDevotional.title,
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
                          hash: featuredImage.blurHash!,
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
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding2x),
                    topRight: Radius.circular(kDefaultPadding2x),
                  )),
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      top: kDefaultPadding),
                  child: Column(
                    children: [
                      //Misters Name and actions

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentDevotional.author,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "${dateTimeFormatter(context, currentDevotional.startDate)} - ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                dateTimeFormatter(
                                    context, currentDevotional.endDate),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/svg/share_icon.svg",
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/svg/heart_icon.svg",
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/svg/settings_icon.svg",
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(currentDevotional.scripture,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(currentDevotional.scriptureReference)),

                      const SizedBox(
                        height: kDefaultPadding2x,
                      ),
                      Text(
                        currentDevotional.content,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Row(
                        children: [
                          NextPreviousButton(
                              onPressed: () async {
                                await devotionalData.getPreviousDevotional();
                                await unsplashImageData.getRandomImage();
                              },
                              isNextButton: false),
                          const Spacer(),
                          NextPreviousButton(onPressed: () async {
                            devotionalData.getNextDevotional();
                            await unsplashImageData.getRandomImage();
                          })
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding2x),
                      Text(
                        "Christ Abode Ministries",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(.4)),
                      ),
                      const SizedBox(height: kDefaultPadding2x),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class NextPreviousButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool? isNextButton;
  final double? elevation;
  final Color? bgColour;
  final Color? iconColour;
  const NextPreviousButton(
      {Key? key,
      required this.onPressed,
      this.isNextButton = true,
      this.elevation,
      this.bgColour,
      this.iconColour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: bgColour ?? Theme.of(context).primaryColor,
        elevation: elevation ?? 0,
        shape: const CircleBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
            isNextButton!
                ? "assets/svg/forward_icon.svg"
                : "assets/svg/back_icon.svg",
            color: iconColour ?? Colors.white),
      ),
    );
  }
}
