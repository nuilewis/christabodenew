import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';
import '../../../models/devotional_model.dart';
import '../../../models/prayer_model.dart';
import '../../../models/unsplash_image.dart';

class DevotionalAndPrayerCard extends StatelessWidget {
  final Devotional? devotional;
  final Prayer? prayer;
  final UnsplashImage featuredImage;
  final VoidCallback onPressed;
  const DevotionalAndPrayerCard(
      {super.key,
      this.devotional,
      this.prayer,
      required this.featuredImage,
      required this.onPressed});

  ///----Documentation----//

  /// A Type agnostic Widget to display the current devotional or
  /// prayer, it requires either the 'prayer' or 'devotional' parameter
  /// to be assigned, or an error will be thrown.
  ///
  /// Both 'prayer' and 'devotional' parameters cannot be passed at the same
  /// time, as it is unsure of which to display, so in such a case, an error would
  /// be thrown asking you to pass one only
  ///
  /// For these reasons, we cannot have the 'prayer' or 'devotional' parameters
  /// be made required since we do not which has to be displayed until explicitly
  /// specified :)

  @override
  Widget build(BuildContext context) {
    ///Throw certain errors
    if (devotional == null && prayer == null) {
      throw UnimplementedError(
          "Devotional and Prayer cannot be null, consider providing either a devotional and prayer");
    } else if (devotional != null && prayer != null) {
      throw UnimplementedError(
          "Cannot provide both a Devotional and Prayer at the same time, please supply only one parameter");
    }

    double width = MediaQuery.sizeOf(context).width * .9;
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding2x),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: (width / 5) * 6.5,
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black.withOpacity(.4),
                        devotional != null
                            ? Theme.of(context).primaryColor
                            : kGreen80,
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding + 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      devotional != null
                          ? "Today's Huios Devotional"
                          : "Today's Prayer Fragrance",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Text(dateTimeFormatter(context, DateTime.now()),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(
                        devotional?.title.toTitleCase() ??
                            prayer!.title.toTitleCase(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.white)),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(devotional?.content ?? prayer!.content,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white)),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        SvgPicture.asset(
                          "assets/svg/forward_icon.svg",
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
