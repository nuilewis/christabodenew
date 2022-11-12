import 'package:equatable/equatable.dart';

class Prayer extends Equatable {
  final String title;
  final String? excerpt;
  final String scripture;
  final String scriptureReference;
  final String content;
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
  @override
  List<Object?> get props =>
      [title, excerpt, content, scripture, scriptureReference, date];
}
