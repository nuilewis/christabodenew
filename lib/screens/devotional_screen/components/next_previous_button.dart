import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NextPreviousButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool? isNextButton;
  final double? elevation;
  final Color? bgColour;
  final Color? iconColour;
  const NextPreviousButton(
      {Key? key,
      required this.onPressed,
      this.isNextButton = true,
      this.elevation,
      this.bgColour,
      this.iconColour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor:
            bgColour ?? Theme.of(context).iconTheme.color!.withOpacity(1),
        elevation: elevation ?? 0,
        shape: const CircleBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          isNextButton!
              ? "assets/svg/chevron_forward_icon.svg"
              : "assets/svg/chevron_backward_icon.svg",
          color: iconColour ?? Theme.of(context).scaffoldBackgroundColor,
          height: 16,
        ),
      ),
    );
  }
}
