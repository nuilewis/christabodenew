import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;

  const Event(
      {required this.name,
      required this.description,
      required this.startDate,
      this.endDate});

  Event copyWith({
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Event(
        name: name ?? this.name,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

  @override
  List<Object?> get props => [name, description, startDate, endDate];
}
