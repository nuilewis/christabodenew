import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'devotional_model.g.dart';

const int _titleHiveIndex = 0;
const int _scriptureHiveIndex = 1;
const int _scriptureRefHiveIndex = 2;
const int _contentHiveIndex = 3;
const int _confessionHiveIndex = 4;
const int _authorHiveIndex = 5;
const int _startDateHiveIndex = 6;
const int _endDateHiveIndex = 7;
const int _isLikedHiveIndex = 8;

@HiveType(typeId: 0)
class Devotional extends Equatable {
  @HiveField(_titleHiveIndex)
  final String title;
  @HiveField(_scriptureHiveIndex)
  final String scripture;
  @HiveField(_scriptureRefHiveIndex)
  final String scriptureReference;
  @HiveField(_contentHiveIndex)
  final String content;
  @HiveField(_confessionHiveIndex)
  final String confessionOfFaith;
  @HiveField(_authorHiveIndex)
  final String author;
  @HiveField(_startDateHiveIndex)
  final DateTime startDate;
  @HiveField(_endDateHiveIndex)
  final DateTime endDate;
  @HiveField(_isLikedHiveIndex)
  final bool isLiked;

  const Devotional({
    required this.title,
    required this.scripture,
    required this.scriptureReference,
    required this.confessionOfFaith,
    required this.author,
    required this.content,
    required this.startDate,
    required this.endDate,
    this.isLiked = false,
  });

  ///-------CopyWith--------///
  Devotional copyWith({
    String? title,
    String? scripture,
    String? author,
    String? scriptureReference,
    String? confessionOfFaith,
    String? content,
    DateTime? startDate,
    DateTime? endDate,
    bool? isLiked,
  }) {
    return Devotional(
      title: title ?? this.title,
      scripture: scripture ?? this.scripture,
      scriptureReference: scriptureReference ?? this.scriptureReference,
      confessionOfFaith: confessionOfFaith ?? this.confessionOfFaith,
      content: content ?? this.content,
      author: author ?? this.author,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  ///---------To Map and From Map methods---------///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "author": author,
      "content": content,
      "confession": confessionOfFaith,
      "start": startDate,
      "end": endDate,
      "scripture": scripture,
      "scriptureRef": scriptureReference,
      "title": title,
    };
    return data;
  }

  factory Devotional.fromMap({required Map<String, dynamic> data}) {
    Timestamp startDate = data["start"];
    Timestamp endDate = data["end"];
    return Devotional(
      title: data["title"],
      scripture: data["scripture"],
      scriptureReference: data["scriptureRef"],
      content: data["content"],
      startDate: startDate.toDate(),
      endDate: endDate.toDate(),
      confessionOfFaith: data["confession"],
      author: data["author"],
    );
  }

  ///-------Empty-------///
  static Devotional empty = Devotional(
      title: "title",
      scripture: "scripture",
      scriptureReference: "scriptureReference",
      confessionOfFaith: "confessionOfFaith",
      author: "author",
      content: "content",
      startDate: DateTime.now(),
      endDate: DateTime.now());
  bool get isEmpty => this == Devotional.empty;
  bool get isNotEmpty => this != Devotional.empty;
  @override
  List<Object> get props => [
        title,
        scripture,
        scriptureReference,
        confessionOfFaith,
        content,
        author,
        startDate,
        endDate,
        isLiked,
      ];
}
