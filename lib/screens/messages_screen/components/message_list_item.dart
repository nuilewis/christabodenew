import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants.dart';

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
      padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding / 2,
          top: kDefaultPadding,
          bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
          color: Theme.of(context).cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  fit: StackFit.expand,
        children: [
          Text(
            messageTitle,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(messageExcerpt,
              maxLines: 2, style: Theme.of(context).textTheme.bodyMedium),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onPressed,
              icon: SvgPicture.asset(
                "assets/svg/forward_icon.svg",
                theme: SvgTheme(
                  currentColor: Theme.of(context).iconTheme.color!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
