import 'package:christabodenew/core/date_time_formatter.dart';
import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';
import '../../../models/prayer_model.dart';

class PrayerCard extends StatefulWidget {
  final Prayer prayer;
  final VoidCallback onPressed;
  const PrayerCard({
    Key? key,
    required this.prayer,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding2x),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding2x),
              color: kBlue40,
              gradient: const LinearGradient(
                  colors: [kBlue, kGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Stack(
              //  fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: -20,
                  right: -20,
                  child: SvgPicture.asset(
                    "assets/svg/prayer_icon.svg",
                    color: Colors.white.withOpacity(.4),
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.prayer.title.toTitleCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(widget.prayer.content,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateTimeFormatter(context, DateTime.now()),
                              style: Theme.of(context).textTheme.bodyText2),
                          SvgPicture.asset("assets/svg/forward_icon.svg",
                              color: Theme.of(context).iconTheme.color),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
