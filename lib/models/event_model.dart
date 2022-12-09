import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'event_model.g.dart';

const int _nameHiveIndex = 0;
const int _descriptionHiveIndex = 1;
const int _startHiveIndex = 2;
const int _endHiveIndex = 3;

@HiveType(typeId: 3)
class Event extends Equatable {
  @HiveField(_nameHiveIndex)
  final String name;
  @HiveField(_descriptionHiveIndex)
  final String description;
  @HiveField(_startHiveIndex)
  final DateTime startDate;
  @HiveField(_endHiveIndex)
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

  ///---------To Map and From Map methods---------///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "name": name,
      "description": description,
      "start": startDate,
      "end": endDate,
    };
    return data;
  }

  // factory constructor that returns a Devotional obj from a Map<String, dynamic>
  factory Event.fromMap({
    required Map<String, dynamic> data,
  }) {
    Timestamp startDate = data["start"];
    Timestamp endDate = data["end"];
    return Event(
      name: data["name"],
      description: data["description"],
      startDate: startDate.toDate(),
      endDate: endDate.toDate(),
    );
  }
  static Event empty = Event(
      name: "name", description: "description", startDate: DateTime.now());
  bool get isEmpty => this == Event.empty;
  bool get isNotEmpty => this != Event.empty;

  @override
  List<Object?> get props => [name, description, startDate, endDate];
}
