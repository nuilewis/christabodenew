import 'package:equatable/equatable.dart';

class Devotional extends Equatable {
  final String title;
  final String? excerpt;
  final String scripture;
  final String scriptureReference;
  final String confessionOfFaith;
  final String content;
  final String author;
  final DateTime startDate;

  final DateTime endDate;

  const Devotional(
      {required this.title,
      this.excerpt,
      required this.scripture,
      required this.scriptureReference,
      required this.confessionOfFaith,
      required this.author,
      required this.content,
      required this.startDate,
      required this.endDate});

  Devotional copyWith({
    String? title,
    String? excerpt,
    String? scripture,
    String? author,
    String? scriptureReference,
    String? confessionOfFaith,
    String? content,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Devotional(
        title: title ?? this.title,
        scripture: scripture ?? this.scripture,
        scriptureReference: scriptureReference ?? this.scriptureReference,
        confessionOfFaith: confessionOfFaith ?? this.confessionOfFaith,
        content: content ?? this.content,
        author: author ?? this.author,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

  @override
  List<Object> get props => [
        title,
        scripture,
        scriptureReference,
        confessionOfFaith,
        content,
        author,
        startDate,
        endDate
      ];
}
