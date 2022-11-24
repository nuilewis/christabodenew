import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'prayer_model.g.dart';

const int _titleHiveIndex = 0;
const int _excerptHiveIndex = 1;
const int _scriptureHiveIndex = 2;
const int _scriptureRefHiveIndex = 3;
const int _contentHiveIndex = 4;
const int _dateHiveIndex = 5;

@HiveType(typeId: 1)
class Prayer extends Equatable {
  @HiveField(_titleHiveIndex)
  final String title;
  @HiveField(_excerptHiveIndex)
  final String? excerpt;
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
      this.excerpt,
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
      [title, excerpt, content, scripture, scriptureReference, date];
}
