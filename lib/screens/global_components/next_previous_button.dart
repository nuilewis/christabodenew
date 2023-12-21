import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NextPreviousButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool? isNextButton;
  final double? elevation;
  final Color? bgColour;
  final Color? iconColour;
  const NextPreviousButton(
      {super.key,
      required this.onPressed,
      this.isNextButton = true,
      this.elevation,
      this.bgColour,
      this.iconColour});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor:
            bgColour ?? Theme.of(context).iconTheme.color!.withOpacity(1),
      ),
      icon: Icon(isNextButton!? FluentIcons.chevron_right_24_regular: FluentIcons.chevron_left_24_regular),
    );
  }
}
