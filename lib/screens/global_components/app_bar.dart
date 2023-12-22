import 'package:christabodenew/core/constants.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool isCalledFromNavBar;
  const CustomAppBar({super.key, this.isCalledFromNavBar = false})
      : preferredSize = const Size.fromHeight(60);

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
              icon: const Icon(FluentIcons.arrow_left_24_regular, color: AppColours.white,)),
    );
  }
}
