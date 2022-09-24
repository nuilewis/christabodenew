class Message {
  final String? category;
  final String messageTitle;
  final String messageContent;
  final String author;
  final DateTime? date;

  Message(
      {this.category,
      required this.messageTitle,
      required this.messageContent,
      required this.author,
      this.date});

  Message copyWith({
    String? category,
    String? messageTitle,
    String? messageContent,
    String? author,
    DateTime? date,
  }) {
    return Message(
        author: author ?? this.author,
        messageTitle: messageTitle ?? this.messageTitle,
        messageContent: messageContent ?? this.messageContent,
        category: category ?? this.category);
  }
}
