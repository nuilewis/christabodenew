import 'dart:ui';

import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';
import '../../../models/event_model.dart';
import '../../../models/unsplash_image.dart';

class FeaturedEventCard extends StatelessWidget {
  final Event event;
  final UnsplashImage featuredImage;
  final VoidCallback onSharePressed;
  const FeaturedEventCard(
      {super.key, required this.event, required this.featuredImage, required this.onSharePressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: screenSize.width,
        height: screenSize.width/2.5,
        decoration: const BoxDecoration(
          // color: Theme.of(context).primaryColor,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/foam_image.jpg"),
          ),
        ),
        child: Stack(
          children: [
            featuredImage.isNotEmpty
                ? BlurHash(
                    imageFit: BoxFit.cover,
                    image: featuredImage.imgUrl,
                    hash: featuredImage.blurHash,
                  )
                : const SizedBox(),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(.4)),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(dateTimeFormatter(context, DateTime.now()),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white)),
                      event.endDate != null
                          ? Text(
                              "to ${dateTimeFormatter(context, event.endDate!)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white))
                          : const SizedBox(),

                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(.1),
                                fixedSize: const Size(48, 48),
                              ),
                              onPressed: onSharePressed,
                              icon: const Icon(FluentIcons.share_android_24_regular, color: AppColours.white,)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(event.name.toTitleCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
