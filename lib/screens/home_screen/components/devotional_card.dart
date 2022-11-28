import 'package:christabodenew/models/devotional_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';

class DevotionalCard extends StatefulWidget {
  final Devotional devotional;
  final VoidCallback onPressed;
  const DevotionalCard({
    Key? key,
    required this.devotional,
    required this.onPressed,
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
            gradient: LinearGradient(
                colors: [kPurple80, kFuchsiaLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Stack(
          //  fit: StackFit.expand,
          children: [
            const SizedBox(width: double.infinity),
            Positioned(
              bottom: -21,
              right: -21,
              child: SvgPicture.asset(
                "assets/svg/read_icon.svg",
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
                    widget.devotional.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(widget.devotional.content,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(dateTimeFormatter(context, DateTime.now()),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white)),
                ],
              ),
            ),
            Positioned(
              bottom: kDefaultPadding,
              right: kDefaultPadding,
              child: IconButton(
                onPressed: widget.onPressed,
                icon: SvgPicture.asset("assets/svg/forward_icon.svg",
                    //color: Theme.of(context).iconTheme.color
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
