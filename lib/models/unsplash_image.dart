import 'package:equatable/equatable.dart';

class UnsplashImage extends Equatable {
  final String? id;
  final String? imgUrl;
  final String? colour;
  final String? blurHash;
  final String? uploaderName;
  final String? uploaderUrl;

  const UnsplashImage(
      {required this.id,
      required this.imgUrl,
      required this.blurHash,
      required this.uploaderName,
      this.colour,
      this.uploaderUrl});

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
        id: json["id"],
        imgUrl: json["urls"]["regular"],
        blurHash: json["blur_hash"],
        uploaderName: json["user"]["name"],
        uploaderUrl: json["user"]["portfolio_url"],
        colour: json["color"]);
  }

  static const UnsplashImage empty =
      UnsplashImage(id: null, imgUrl: null, blurHash: null, uploaderName: null);

  bool get isEmpty => this == UnsplashImage.empty;
  bool get isNotEmpty => this != UnsplashImage.empty;

  @override
  List<Object?> get props =>
      [id, imgUrl, blurHash, colour, uploaderName, uploaderUrl];
}
