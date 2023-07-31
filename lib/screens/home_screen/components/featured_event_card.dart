import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';
import '../../../models/event_model.dart';
import '../../../models/unsplash_image.dart';

class FeaturedEventCard extends StatelessWidget {
  final Event event;
  final UnsplashImage featuredImage;
  const FeaturedEventCard(
      {super.key, required this.event, required this.featuredImage});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding2x),
      child: Container(
        width: width,
        height: (width) * .5,
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
              padding: const EdgeInsets.all(kDefaultPadding + 8),
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
                          : SizedBox(),
                    ],
                  ),
                  const Spacer(),
                  Text(event.name.toTitleCase(),
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
