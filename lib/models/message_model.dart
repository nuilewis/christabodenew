import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'message_model.g.dart';

const int _categoryHiveIndex = 0;
const int _titleHiveIndex = 1;
const int _contentHiveIndex = 2;
const int _authorHiveIndex = 3;
const int _dateHiveIndex = 4;

@HiveType(typeId: 2)
class Message extends Equatable {
  @HiveField(_categoryHiveIndex)
  final String? category;
  @HiveField(_titleHiveIndex)
  final String title;
  @HiveField(_contentHiveIndex)
  final String content;
  @HiveField(_authorHiveIndex)
  final String? author;
  @HiveField(_dateHiveIndex)
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

  static const Message empty =
      Message(title: "title", content: "content", author: "author");
  bool get isEmpty => this == Message.empty;
  bool get isNotEmpty => this != Message.empty;

  @override
  List<Object?> get props => [author, title, content, category];
}
