import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
          image: const DecorationImage(
              image: AssetImage("assets/images/road_image.jpg"),
              fit: BoxFit.cover),
          gradient: LinearGradient(
            colors: [Colors.transparent, kDark40],
            //  stops: [0.3, 0.9 ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: kDefaultPadding,
              bottom: kDefaultPadding,
              child: Text(
                "Video title",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 16, color: Colors.white),
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/play_icon.svg",
                  height: kDefaultPadding2x,
                  theme: const SvgTheme(
                    currentColor: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
