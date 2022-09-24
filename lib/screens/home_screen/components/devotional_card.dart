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
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding2x),
            color: widget.isPrayerCard! ? kBlue20:  kFuchsiaLight),
        child: Stack(
        //  fit: StackFit.expand,
          children: [
            const SizedBox(width: double.infinity),
            Positioned(
              bottom: -20,
              right: -20,
              child: SvgPicture.asset(
                widget.isPrayerCard!
                    ? "assets/svg/prayer_icon.svg"
                    : "assets/svg/read_icon.svg",
                    
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
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(widget.excerpt,
                      style: Theme.of(context).textTheme.bodyText2),
               
                ],
              ),
            )
            ,
               Positioned(
                    bottom: kDefaultPadding,
                    right: kDefaultPadding,
                    child: IconButton(
                      onPressed: widget.onPressed,
                      icon: SvgPicture.asset("assets/svg/forward_icon.svg"),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
