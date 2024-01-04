import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

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
    //    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
      ),
      icon: Icon(isNextButton!? FluentIcons.chevron_right_24_regular: FluentIcons.chevron_left_24_regular),
    );
  }
}
