import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
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
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding2x),
            color: kBlue40),
        child: Stack(
          //  fit: StackFit.expand,
          children: [
            const SizedBox(width: double.infinity),
            Positioned(
              bottom: -20,
              right: -20,
              child: SvgPicture.asset(
                "assets/svg/prayer_icon.svg",
                color: Colors.white.withOpacity(.4),
                height: 150,
              ),
            ),
            Positioned(
              top: kDefaultPadding,
              left: kDefaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.prayer.prayerTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(widget.prayer.prayerExcerpt ?? "Message excerpt",
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            ),
            Positioned(
              bottom: kDefaultPadding,
              right: kDefaultPadding,
              child: IconButton(
                onPressed: widget.onPressed,
                icon: SvgPicture.asset("assets/svg/forward_icon.svg", color: Theme.of(context).iconTheme.color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
