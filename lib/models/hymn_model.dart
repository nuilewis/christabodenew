import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'hymn_model.g.dart';

const int _titleHiveIndex = 0;
const int _contentHiveIndex = 1;
const int _numberHiveIndex = 2;
const int _isLikedHiveIndex = 3;

@HiveType(typeId: 5)
class Hymn extends Equatable {
  @HiveField(_titleHiveIndex)
  final String title;
  @HiveField(_contentHiveIndex)
  final String content;
  @HiveField(_numberHiveIndex)
  final int number;
  @HiveField(_isLikedHiveIndex)
  final bool isLiked;

  const Hymn({
    required this.title,
    required this.content,
    required this.number,
    this.isLiked = false,
  });

  ///-------CopyWith--------///
  Hymn copyWith({
    String? title,
    String? content,
    int? number,
    bool? isLiked,
  }) {
    return Hymn(
      title: title ?? this.title,
      content: content ?? this.content,
      number: number ?? this.number,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  ///---------To Map and From Map methods---------///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "content": content,
      "number": number,
      "title": title,
    };
    return data;
  }

  factory Hymn.fromMap({required Map<String, dynamic> data}) {
    return Hymn(
      title: data["title"],
      content: data["content"],
      number: data["number"],
    );
  }

  ///-------Empty-------///
  static Hymn empty =
      const Hymn(title: "title", number: 0, content: "content", isLiked: false);

  bool get isEmpty => this == Hymn.empty;
  bool get isNotEmpty => this != Hymn.empty;
  @override
  List<Object> get props => [
        title,
        content,
        isLiked,
        number,
      ];
}
