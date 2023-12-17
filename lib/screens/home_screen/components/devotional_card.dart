import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:christabodenew/models/devotional_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';

class DevotionalCard extends StatefulWidget {
  final Devotional devotional;
  final VoidCallback onPressed;
  const DevotionalCard({
    super.key,
    required this.devotional,
    required this.onPressed,
  });

  @override
  State<DevotionalCard> createState() => _DevotionalCardState();
}

class _DevotionalCardState extends State<DevotionalCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding2x),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding2x),
              gradient: const LinearGradient(
                  colors: [AppColours.blueSeed  , AppColours.redSeed],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Stack(
            children: [
              Positioned(
                bottom: -21,
                right: -21,
                child: SvgPicture.asset(
                  "assets/svg/read_icon.svg",
                  theme: SvgTheme(
                    currentColor: Colors.white.withOpacity(.4),
                  ),
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      widget.devotional.title.toTitleCase(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(widget.devotional.content,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(dateTimeFormatter(context, DateTime.now()),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white)),
                        SvgPicture.asset(
                          "assets/svg/forward_icon.svg",
                          //color: Theme.of(context).iconTheme.color
                          theme: const SvgTheme(currentColor: Colors.white),
                        ),
                      ],
                    )
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
