
class Devotional {
  final String messageTitle;
  final String? messageExcerpt;
  final String scripture;
  final String scriptureReference;
  final String confessionOfFaith;
  final String messageContent;
  final String author;
  final DateTime startDate;

  final DateTime endDate;

  Devotional(
      {required this.messageTitle,
      this.messageExcerpt,
      required this.scripture,
      required this.scriptureReference,
      required this.confessionOfFaith,
      required this.author,
      required this.messageContent,
      required this.startDate,
      required this.endDate});

  Devotional copyWith({
    String? messageTitle,
    String? messageExcerpt,
    String? scripture,
    String? author,
    String? scriptureReference,
    String? confessionOfFaith,
    String? messageContent,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Devotional(
        messageTitle: messageTitle ?? this.messageTitle,
        scripture: scripture ?? this.scripture,
        scriptureReference: scriptureReference ?? this.scriptureReference,
        confessionOfFaith: confessionOfFaith ?? this.confessionOfFaith,
        messageContent: messageContent ?? this.messageContent,
        author: author?? this.author,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

}
