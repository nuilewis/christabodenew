import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../models/unsplash_image.dart';

class FeaturedImage extends StatelessWidget {
  final UnsplashImage featuredImage;
  const FeaturedImage({
    super.key,
    required this.featuredImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        featuredImage.isEmpty
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/foam_image.jpg"),
                        fit: BoxFit.cover)),
              )
            : SizedBox.expand(
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  image: featuredImage.imgUrl,
                  hash: featuredImage.blurHash,
                ),
              ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.25),
          ),
        ),
        // Positioned(
        //   right: kDefaultPadding,
        //   bottom: kDefaultPadding * 3,
        //   child: RichText(
        //     text: TextSpan(children: [
        //       TextSpan(
        //           text: "Image by ",
        //           style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //               color: Colors.white.withOpacity(.7), fontSize: 9)),
        //       TextSpan(
        //           text: featuredImage.uploaderName,
        //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //               color: Colors.white.withOpacity(.7), fontSize: 9)),
        //       TextSpan(
        //           text: " - Unsplash",
        //           style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //               color: Colors.white.withOpacity(.7), fontSize: 9))
        //     ]),
        //   ),
        // )
      ],
    );
  }
}
