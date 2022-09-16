import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class DevotionalCard extends StatefulWidget {
  final String title;
  final String excerpt;
  final VoidCallback onPressed;
  final bool? isPrayerCard;
  const DevotionalCard({
    Key? key,
    required this.title,
    required this.excerpt,
    required this.onPressed,
    this.isPrayerCard = false,
  }) : super(key: key);

  @override
  State<DevotionalCard> createState() => _DevotionalCardState();
}

class _DevotionalCardState extends State<DevotionalCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding2x),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding2x),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding2x),
            color: widget.isPrayerCard! ? kFuchsia80 : kBlue40),
        child: Stack(
          children: [
            Positioned(
              bottom: -20,
              right: -20,
              child: SvgPicture.asset(
                widget.isPrayerCard!
                    ? "assets/svg/prayer_icon.svg"
                    : "assets/svg/devotional_icon.svg",
                color: Colors.white.withOpacity(.1),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(widget.excerpt,
                      style: Theme.of(context).textTheme.bodyText2),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: widget.onPressed,
                      icon: SvgPicture.asset("assets/svg/forward_icon.svg"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
