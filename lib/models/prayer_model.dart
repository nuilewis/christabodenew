import 'package:equatable/equatable.dart';

class Prayer extends Equatable {
  final String title;
  final String? excerpt;
  final String scripture;
  final String scriptureReference;
  final String message;
  final DateTime date;

  const Prayer(
      {required this.title,
      this.excerpt,
      required this.scripture,
      required this.scriptureReference,
      required this.message,
      required this.date});

  Prayer copyWith({
    String? title,
    String? excerpt,
    String? scripture,
    String? scriptureReference,
    String? message,
    DateTime? date,
  }) {
    return Prayer(
        title: title ?? this.title,
        scripture: scripture ?? this.scripture,
        scriptureReference: scriptureReference ?? this.scriptureReference,
        message: message ?? this.message,
        date: date ?? this.date);
  }

  @override
  List<Object?> get props =>
      [title, excerpt, message, scripture, scriptureReference, date];
}
