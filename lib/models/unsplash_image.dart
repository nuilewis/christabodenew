import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'unsplash_image.g.dart';

@HiveType(typeId: 6)
class UnsplashImage extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String imgUrl;
  @HiveField(2)
  final String blurHash;
  @HiveField(3)
  final String? colour;
  @HiveField(4)
  final String? uploaderName;
  @HiveField(5)
  final String? uploaderUrl;
  @HiveField(6)
  final DateTime? date;

  const UnsplashImage({
    required this.id,
    required this.imgUrl,
    required this.blurHash,
    required this.uploaderName,
    this.colour,
    this.uploaderUrl,
    this.date,
  });

  factory UnsplashImage.fromMap(Map<String, dynamic> data) {
    return UnsplashImage(
      id: data["id"],
      imgUrl: data["urls"]["regular"],
      blurHash: data["blur_hash"],
      uploaderName: data["user"]["name"],
      uploaderUrl: data["user"]["portfolio_url"],
      colour: data["color"],
      date: DateTime.now(),
    );
  }

  static const UnsplashImage empty =
      UnsplashImage(id: "", imgUrl: "", blurHash: "", uploaderName: "");

  bool get isEmpty => this == UnsplashImage.empty;
  bool get isNotEmpty => this != UnsplashImage.empty;

  @override
  List<Object?> get props =>
      [id, imgUrl, blurHash, colour, uploaderName, uploaderUrl, date];
}
