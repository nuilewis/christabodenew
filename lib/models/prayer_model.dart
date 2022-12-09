import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'prayer_model.g.dart';

const int _titleHiveIndex = 0;
const int _scriptureHiveIndex = 1;
const int _scriptureRefHiveIndex = 2;
const int _contentHiveIndex = 3;
const int _dateHiveIndex = 4;

@HiveType(typeId: 1)
class Prayer extends Equatable {
  @HiveField(_titleHiveIndex)
  final String title;
  @HiveField(_scriptureHiveIndex)
  final String scripture;
  @HiveField(_scriptureRefHiveIndex)
  final String scriptureReference;
  @HiveField(_contentHiveIndex)
  final String content;
  @HiveField(_dateHiveIndex)
  final DateTime date;

  const Prayer(
      {required this.title,
      required this.scripture,
      required this.scriptureReference,
      required this.content,
      required this.date});

  Prayer copyWith({
    String? title,
    String? excerpt,
    String? scripture,
    String? scriptureReference,
    String? content,
    DateTime? date,
  }) {
    return Prayer(
        title: title ?? this.title,
        scripture: scripture ?? this.scripture,
        scriptureReference: scriptureReference ?? this.scriptureReference,
        content: content ?? this.content,
        date: date ?? this.date);
  }

  ///---------To Map and From Map methods---------///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "content": content,
      "date": date,
      "scripture": scripture,
      "scriptureRef": scriptureReference,
      "title": title,
    };
    return data;
  }

  // factory constructor that returns a Devotional obj from a Map<String, dynamic>
  factory Prayer.fromMap({
    required Map<String, dynamic> data,
  }) {
    Timestamp date = data["date"];
    return Prayer(
      title: data["title"],
      scripture: data["scripture"],
      scriptureReference: data["scriptureRef"],
      content: data["content"],
      date: date.toDate(),
    );
  }

  static Prayer empty = Prayer(
      title: "",
      scripture: "scripture",
      scriptureReference: "scriptureReference",
      content: "content",
      date: DateTime.now());
  bool get isEmpty => this == Prayer.empty;
  bool get isNotEmpty => this != Prayer.empty;

  static final List<Prayer> demoData = [
    Prayer(
        title: "prayer 1",
        scripture: "scripture",
        scriptureReference: "scriptureReference",
        content: "content",
        date: DateTime.now()),
    Prayer(
        title: "prayer 2",
        scripture: "scripture",
        scriptureReference: "scriptureReference",
        content: "content",
        date: DateTime.now()),
  ];

  @override
  List<Object?> get props =>
      [title, content, scripture, scriptureReference, date];
}
