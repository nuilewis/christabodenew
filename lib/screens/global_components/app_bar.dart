import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool isCalledFromNavBar;
  const CustomAppBar({Key? key, this.isCalledFromNavBar = false})
      : preferredSize = const Size.fromHeight(60),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      leading: isCalledFromNavBar
          ? const SizedBox()
          : IconButton(
              onPressed: () {
                HapticFeedback.lightImpact;
                Feedback.forTap(context);
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                "assets/svg/back_icon.svg",
                theme: SvgTheme(
                  currentColor: Theme.of(context).iconTheme.color!,
                ),
              )),
    );
  }
}
