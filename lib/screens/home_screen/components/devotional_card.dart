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
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AspectRatio(
          aspectRatio: 20.0 / 9.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultPadding2x),
                gradient: LinearGradient(
                    colors: [kPurple60, kFuchsia80],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: Stack(
              children: [
                Positioned(
                  bottom: -21,
                  right: -21,
                  child: SvgPicture.asset(
                    "assets/svg/read_icon.svg",
                    color: Colors.white.withOpacity(.4),
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: double.infinity),
                      Text(
                        widget.devotional.title.toTitleCase(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                      ),
                      const Spacer(),
                      Text(widget.devotional.content,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white)),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateTimeFormatter(context, DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white)),
                          SvgPicture.asset("assets/svg/forward_icon.svg",
                              //color: Theme.of(context).iconTheme.color
                              color: Colors.white),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
