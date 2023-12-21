import 'package:christabodenew/models/models.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/core.dart';
import 'featured_image.dart';
import 'next_previous_button.dart';

class Content extends StatefulWidget {
  final String title;
  final String content;
  final UnsplashImage featuredImage;
  final DateTime? endDate;
  final DateTime? startDate;
  final String? author;
  final String? scripture;
  final String? scriptureReference;
  final ContentType contentType;
  final String? confessionOfFaith;
  final VoidCallback onLikeButtonPressed;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onShareButtonPressed;
  final VoidCallback onPreviousButtonPressed;
  final bool isLiked;

  const Content({
    super.key,
    required this.contentType,
    required this.title,
    required this.content,
    required this.featuredImage,
    required this.onLikeButtonPressed,
    required this.onNextButtonPressed,
    required this.onPreviousButtonPressed,
    required this.onShareButtonPressed,
    required this.isLiked,
    this.startDate,
    this.endDate,
    this.author,
    this.scripture,
    this.scriptureReference,
    this.confessionOfFaith,
  });

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  late final AnimationController scrollAnimationController;
  late final Animation<Color?> colorAnimation;

  @override
  void initState() {
    scrollAnimationController = AnimationController(
      lowerBound: 0,
      upperBound: 280,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    colorAnimation = ColorTween(begin: Colors.white, end: AppColours.black)
        .animate(scrollAnimationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverLayoutBuilder(builder: (BuildContext context, constraints) {
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
            scrollAnimationController.value = constraints.scrollOffset / 280;
          } else {
            scrollAnimationController.value = 1;
          }

          //print(constraints.scrollOffset);

          return SliverAppBar(
            onStretchTrigger: () async {
              ///Todo: you cna put a method to refresh the page or soemthing lidat.
            },
            iconTheme: Theme.of(context).iconTheme,
            surfaceTintColor: Colors.white,
            collapsedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              titlePadding: const EdgeInsets.all(kDefaultPadding),
              expandedTitleScale: 1,
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding2x),
                  child: Text(
                    widget.title.toTitleCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: AppColours.white),
                  ),
                ),
              ),
              background: Stack(
                children: [
                  FeaturedImage(featuredImage: widget.featuredImage),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
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
          child: Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: Column(
              children: [
                //Misters Name and actions

                Row(
                  children: [
                    Visibility(
                      visible: widget.contentType != ContentType.hymn,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            //Only show if the author is available
                            visible: widget.author != null,
                            child: Text("${widget.author}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w800)),
                          ),
                          Text(
                            "${dateTimeFormatter(context, widget.startDate!)} to ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Visibility(
                            visible: widget.endDate != null,
                            child: Text(
                                dateTimeFormatter(context, widget.endDate??DateTime.now()),
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    IconButton(
                        onPressed: widget.onShareButtonPressed,
                        icon: Icon(FluentIcons.share_android_24_regular)),
                    IconButton(
                      onPressed: widget.onLikeButtonPressed,
                      icon: Icon(widget.isLiked
                          ? FluentIcons.heart_24_filled
                          : FluentIcons.heart_24_regular),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Visibility(
                  visible: widget.scripture != null,
                  child: Text(widget.scripture!,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Visibility(
                  visible: widget.scriptureReference != null,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(widget.scriptureReference!)),
                ),

                const SizedBox(
                  height: kDefaultPadding2x,
                ),
                Text(
                  widget.content,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: kDefaultPadding),
                Visibility(
                  visible: widget.contentType == ContentType.devotional,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confession of faith, and Prayer",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        "${widget.confessionOfFaith}",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    NextPreviousButton(
                        onPressed: widget.onPreviousButtonPressed,
                        isNextButton: false),
                    const Spacer(),
                    NextPreviousButton(onPressed: widget.onNextButtonPressed)
                  ],
                ),
                const SizedBox(height: kDefaultPadding2x),
                Text(
                  "Christ Abode Ministries",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(.4)),
                ),
                const SizedBox(height: kDefaultPadding2x),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
