import 'dart:ui';

import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

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

    Size screenSize = MediaQuery.sizeOf(context);
    bool isLiked = false;

    if(devotional!=null){
      isLiked = devotional!.isLiked;
    }else if(
    prayer!=null
    ){
      isLiked = prayer!.isLiked;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onPressed,
      child: Ink(
        width: screenSize.width * .65,
        height: screenSize.width * .8,
        decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
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
  width: screenSize.width * .65,
  height: screenSize.width * .8,
  color: AppColours.black.withOpacity(.3),),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                devotional != null
                                    ? "Huios Devotional"
                                    : "Prayer Fragrance",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(dateTimeFormatter(context, DateTime.now()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child:

                               Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  color: Colors.white.withOpacity(.1),
                                ),

                                  child: Icon( isLiked? FluentIcons.heart_24_filled: FluentIcons.heart_24_regular, color: AppColours.white,))
                            ),

                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              devotional?.title.toTitleCase() ??
                                  prayer!.title.toTitleCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white, height: 1.3)),
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        const SizedBox(width: kDefaultPadding),
                        const Icon(FluentIcons.arrow_right_24_regular, color: AppColours.white,),

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
