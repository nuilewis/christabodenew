import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String? category;
  final String title;
  final String content;
  final String author;
  final DateTime? date;

  const Message(
      {this.category,
      required this.title,
      required this.content,
      required this.author,
      this.date});

  Message copyWith({
    String? category,
    String? title,
    String? content,
    String? author,
    DateTime? date,
  }) {
    return Message(
        author: author ?? this.author,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category);
  }

  @override
  List<Object?> get props => [author, title, content, category];
}
