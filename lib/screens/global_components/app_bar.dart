
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{

  @override
final Size preferredSize;
  const CustomAppBar({Key? key}): preferredSize = const Size.fromHeight(80), super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
            onPressed: () {
              HapticFeedback.lightImpact;
              Feedback.forTap(context);
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/svg/back_icon.svg",
                color: Theme.of(context).iconTheme.color)),
      );
  }

}