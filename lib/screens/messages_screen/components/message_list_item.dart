

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class MessageListItem extends StatelessWidget {
  final String messageTitle;
  final String messageExcerpt;
  final VoidCallback onPressed;
  const MessageListItem({
    Key? key,
    required this.messageTitle,
    required this.messageExcerpt,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
          color: Theme.of(context).cardColor),
      child: Stack(
        //  fit: StackFit.expand,
        children: [
          const SizedBox(width: double.infinity),
          Positioned(
            top: kDefaultPadding,
            left: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  messageTitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 24),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(messageExcerpt,
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          Positioned(
            bottom: kDefaultPadding,
            right: kDefaultPadding,
            child: IconButton(
              onPressed: onPressed,
              icon: SvgPicture.asset(
                "assets/svg/forward_icon.svg",
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
