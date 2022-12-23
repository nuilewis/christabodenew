import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../../core/constants.dart';
import '../../../models/unsplash_image.dart';

class FeaturedImage extends StatelessWidget {
  final UnsplashImage featuredImage;
  const FeaturedImage({
    Key? key,
    required this.featuredImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: BlurHash(
            imageFit: BoxFit.cover,
            image: featuredImage.imgUrl,
            hash: featuredImage.blurHash,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.2),
          ),
        ),
        Positioned(
          right: kDefaultPadding,
          bottom: kDefaultPadding,
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Image by ",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white.withOpacity(.7), fontSize: 9)),
              TextSpan(
                  text: featuredImage.uploaderName,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white.withOpacity(.7), fontSize: 9)),
              TextSpan(
                  text: " - Unsplash",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white.withOpacity(.7), fontSize: 9))
            ]),
          ),
        )
      ],
    );
  }
}
